	#!/bin/bash
. ../lib.sh

#core/get_hw_types
svc='core/get_hw_types'
params='{"filterType":"name","filterValue":["ATrack"],"includeType":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	hwid=`echo $resp | jq '.[]' | jq '.id'`
	#echo $hwid
	mresp='[{"id":'$hwid',"uid2":1,"name":"ATrack","hw_category":"auto","tp":"20219","up":"20219"}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

#core/create_unit
svc='core/create_unit'
params='{"creatorId":'$uitemId',"name":"core_create_unit","hwTypeId":'$hwid',"dataFlags":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
id=`echo $resp | jq '.item.id'`
    #echo $resp
	mresp='{"item":{"nm":"core_create_unit","cls":2,"id":'$id',"mu":0,"uacl":880333094911},"flags":1}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#update update_unique_id2
svc='unit/update_unique_id2'
params='{"itemId":'$id',"uniqueId2":"test2"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"uid2":"test2"}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#upload image
svc='unit/upload_image'
params='{"itemId":'$id'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" -F "params=$params" -F "image=@upload_image.png"`
	#echo $resp
	mresp='{}'
	if [[ "$mresp" != "$resp" ]]; 
		then error
	fi

#core/get_hw_cmds
svc='core/get_hw_cmds'
params='{"deviceTypeId":0,"unitId":'$id'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp 
	mresp='{"gsm":["custom_msg"],"tcp":["custom_msg","custom_msg_gprs","driver_msg","query_photo","send_position","send_route","send_waypoints","set_odometer"],"udp":["custom_msg","custom_msg_gprs","driver_msg","query_photo","send_position","send_route","send_waypoints","set_odometer"],"vrt":["custom_msg","custom_msg_gprs","iridium_custom_msg"]}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

#core/delete_item
svc='item/delete_item'
params='{"itemId":'$id'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi