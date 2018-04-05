#!/bin/bash
source ../lib.sh


# Get hw types
params='{"filterType":"name","filterValue":["ATrack"],"includeType":1}'
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=core/get_hw_types&sid=$sid"`
#echo $resp
    hwid=`echo $response | jq '.[].id'`
    mresp='[{"id":'$hwid',"uid2":1,"name":"ATrack","hw_category":"auto","tp":"20219","up":"20219"}]'
    #echo $mresp
    if [[ "$mresp" != "$response" ]];
        then error
    fi


################################
# Create unit
################################

# Params list
params='{"creatorId":'$uitemId',"name":"get_result_photo","hwTypeId":'$hwid',"dataFlags":1}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=core/create_unit&sid=$sid"`
newObjectID=`echo $response | jq '.item.id'`
equivalent='{"item":{"nm":"get_result_photo","cls":2,"id":'$newObjectID',"mu":0,"uacl":880333094911},"flags":1}'

# Check is error
if [[ ${response:0:8} == '{"error"' ]]; then
    error "Object create error";
elif [[ "$equivalent" != "$response" ]];
    then error
fi

################################
# Import messages
################################

# Params list
params='{"itemId":'$newObjectID',"eventHash":"message_layer1"}'

# Execute command and compare with equivalent
response=`curl -sX POST -F "params=$params" -F "filename=@data/test.wlb" "$server?svc=exchange/import_messages&sid=$sid"`
equivalent='{}'

# Check is error
if [[ ${response:0:8} == '{"error"' ]]; then
    error "Import messages error";
elif [[ "$equivalent" != "$response" ]];
    then error
fi

sleep 1

################################
# Create report
################################

# Params list
params='{"n":"get_result_photo","ct":"avl_unit","p":"{\"bind\":null}","tbl":[{"n":"unit_stats","l":"Статистика","f":0,"c":"","cl":"","p":"{\"address_format\":\"1255211008_10_5\",\"time_format\":\"%Y-%m-%E_%H:%M:%S\",\"us_units\":0}","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Address\",\"Time Format\"]","s":"[\"address_format\",\"time_format\",\"us_units\"]"},{"l":"Изображения","c":"[\"photos_count\"]","n":"unit_photos","cl":"[\"Изображения\"]","sl":"","s":"","f":0,"sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"p":""}],"id":0,"itemId":'$itemId',"callMode":"create"}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/update_report&sid=$sid&lang=ru"`

# Check is error
if [[ ${response:0:8} == '{"error"' ]]; then
    error "Report creation error";
fi

# Get report id
reportId=`expr match "$response" '.\([0-9]*\),'`

################################
# Execute report
################################

# Params list
params='{"reportResourceId":'$itemId',"reportTemplateId":'$reportId',"reportTemplate":"Edited report","reportObjectId":'$newObjectID',"reportObjectSecId":0,"interval":{"flags":16777216,"from":1480539600,"to":1489066376}}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/exec_report&sid=$sid"`

# Check is error
if [[ ${response:0:8} == '{"error"' ]]; then
    error "Report execution error - $response";
elif [[ ${response:1:14} != '"reportResult"' ]]; then
    error "Can't execute report with id:$reportId"
fi

################################
# Get result photo
################################

# Params list
params='{"attachmentIndex":0,"border":300}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/get_result_photo&sid=$sid"`

# Check is error
if [[ ${response:0:8} == '{"error"' ]]; then
    error "Get result map error - $response";
#elif [ "$response" != "$equivalent" ]; then
#    error "PNG image error - $response"
fi

################################
# Get results rows
################################

# Params list
params='{"tableIndex":0,"indexFrom":0,"indexTo":0}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/get_result_rows&sid=$sid" `
equivalent='[{"n":0,"i1":0,"i2":0,"t1":0,"t2":0,"d":0,"c":["1"]}]'

# Check is error
if [[ ${response:0:8} == '{"error"' ]]; then
    error "Report result rows - $response";
elif [[ "$response" != "$equivalent" ]]; then
    error "Data isn't equal - $response"
fi


################################
# Get results subrows
# Check withour subrows - need {"error":0}
################################

# Params list
params='{"tableIndex":0,"rowIndex":0}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/get_result_subrows&sid=$sid" `
equivalent='{"error":0}'

# Check is error
if [[ "$response" != "$equivalent" ]]; then
    error "Data isn't equal - $response"
fi

################################
# Delete report
################################

# Params list
params='{"id":'$reportId',"itemId":'$itemId',"callMode":"delete"}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/update_report&sid=$sid"`
equivalent="[$reportId,null]"

# Check is error
if [[ ${response:0:8} == '{"error"' ]]; then
    error "Report delete error - $response";
elif [[ "$response" != "$equivalent" ]]; then
    error "Can't delete report with id:$reportId"
fi


################################
# Delete Item
################################

# Params list
params='{"itemId":'$newObjectID'}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=item/delete_item&sid=$sid"`
equivalent="{}"

# Check is error
if [[ ${response:0:8} == '{"error"' ]]; then
    error "Item delete error - $response";
elif [[ "$response" != "$equivalent" ]]; then
    error "Can't delete item with id: $newObjectID"
fi