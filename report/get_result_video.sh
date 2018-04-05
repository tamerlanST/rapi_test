#!/bin/bash
source ../lib.sh


################################
# Get hw types
################################

# Params list
params='{"filterType":"name","filterValue":["ATrack"],"includeType":1}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=core/get_hw_types&sid=$sid"`
hwid=`echo $response | jq '.[].id'`

equivalent='[{"id":'$hwid',"uid2":1,"name":"ATrack","hw_category":"auto","tp":"20219","up":"20219"}]'

if [[ "$equivalent" != "$response" ]];
    then error
fi


################################
# Create unit
################################

# Params list
params='{"creatorId":'$uitemId',"name":"get_result_video","hwTypeId":'$hwid',"dataFlags":1}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=core/create_unit&sid=$sid"`
newObjectID=`echo $response | jq '.item.id'`
equivalent='{"item":{"nm":"get_result_video","cls":2,"id":'$newObjectID',"mu":0,"uacl":880333094911},"flags":1}'

# Check is error
if [[ ${response:0:8} == '{"error"' ]]; then
    error "Object create error";
elif [[ "$equivalent" != "$response" ]];
    then error $response
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
params='{"n":"Check video table","ct":"avl_unit","p":"{\"bind\":null}","tbl":[{"n":"unit_stats","l":"Статистика","f":0,"c":"","cl":"","p":"{\"address_format\":\"0_10_5\",\"time_format\":\"%Y-%m-%E_%H:%M:%S\",\"us_units\":0}","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Address\",\"Time Format\"]","s":"[\"address_format\",\"time_format\",\"us_units\"]"},{"l":"Видео","c":"[\"videos_count\"]","n":"unit_videos","cl":"[\"Видео\"]","sl":"","s":"","f":0,"sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"p":""}],"id":0,"itemId":'$itemId',"callMode":"create"}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/update_report&sid=$sid&lang=ru"`

# Check is error
if [ ${response:0:8} == '{"error"' ]; then
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
if [ ${response:0:8} == '{"error"' ]; then
    error "Report execution error - $response";
elif [ ${response:1:14} != '"reportResult"' ]; then
    error "Can't execute report with id:$reportId"
fi

################################
# Get result video
################################

# Params list
params='{"attachmentIndex":0,"border":300}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/get_result_video&sid=$sid"`
equivalent='{"video_uri":"http:\/\/media.wialon.com\/75507336-e31f-11e6-8abf-500c40000a0e.mp4","video_type":"video\/mp4"}'

# Check is error
if [ ${response:0:8} == '{"error"' ]; then
    error "Get result map error - $response";
elif [ "$response" != "$equivalent" ]; then
    error "PNG image error - $response"
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
if [ ${response:0:8} == '{"error"' ]; then
    error "Report delete error - $response";
elif [ "$response" != "$equivalent" ]; then
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
    error "Report delete error - $response";
elif [[ "$response" != "$equivalent" ]]; then
    error "Can't delete item with id:$newObjectID"
fi