#!/bin/bash
#created by pash
. ../lib.sh
unixtime=`date +%s`
let "timeF=`date +%s`-3000"
let "timeA=`date +%s`+3000"
#echo $timeA
#echo $timeF
#echo $sid

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
resp=`curl -s "$server?svc=core/create_unit&params=\{\"creatorId\":$uitemId,\"name\":\"core_create_unit\",\"hwTypeId\":$hwid,\"dataFlags\":1\}&sid=$sid"`
ucid=`expr match "$resp" '.*"id":\([0-9]*\).*'`
#    echo $resp
	mresp={\"item\":{\"nm\":\"core_create_unit\",\"cls\":2,\"id\":$ucid,\"mu\":0,\"uacl\":880333094911},\"flags\":1}
    #echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "render/get_messages_create_unit"
	fi

#import message
params="{\"itemId\":$ucid,\"eventHash\":\"message_layer1\"}"
resp=`curl -sX POST -F "params=$params" -F "filename=@test1.wln" "$server?svc=exchange/import_messages&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "render/1$rname"
	#else echo "success"
	fi
sleep 1

#create message layer
params="\{\"layerName\":\"message_layer1\",\"itemId\":$ucid,\"timeFrom\":1,\"timeTo\":$timeA,\"tripDetector\":0,\"flags\":0,\"trackWidth\":4,\"trackColor\":\"cc0000ff\",\"annotations\":0,\"points\":1,\"pointColor\":\"cc0000ff\",\"arrows\":1\}"
resp=`curl -s "$server?svc=render/create_messages_layer&params=$params&sid=$sid" | sed 's/"count":[^"]*,//g' | sed 's/"time":[^"]*,//g' | sed 's/"id":[^"]*,//g'`
#	echo $resp
	mresp='{"name":"message_layer1","bounds":[47.0992833333,17.546715,47.0992833333,17.546715],"units":[{"msgs":{"first":{"lat":47.0992851257,"lon":17.5467147827},"last":{"lat":47.0992851257,"lon":17.5467147827}},"mileage":0,"max_speed":0}]}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "render/2$rname"
	fi

#get messages
params="\{\"layerName\":\"message_layer1\",\"indexFrom\":0,\"indexTo\":3,\"unitId\":$ucid\}"
resp=`curl -s "$server?svc=render/get_messages&params=$params&sid=$sid" | sed 's/"t":[^"]*,//g' | sed 's/"f":[^"]*,//g'`
	#echo $resp
	mresp='[{"tp":"ud","pos":{"y":47.0992833333,"x":17.546715,"z":230,"s":0,"c":83,"sc":8},"i":0,"lc":0,"p":{"hdop":1.1,"adc1":2891,"adc2":2882,"io_caused":7,"power":25763,"gsm_operator":21601,"vod":1}},{"tp":"ud","pos":{"y":47.0992833333,"x":17.546715,"z":230,"s":0,"c":83,"sc":8},"i":0,"lc":0,"p":{"hdop":1.1,"adc1":2891,"adc2":2882,"io_caused":7,"power":25763,"gsm_operator":21601,"vod":1}},{"tp":"ud","pos":{"y":47.0992833333,"x":17.546715,"z":230,"s":0,"c":83,"sc":8},"i":0,"lc":0,"p":{"hdop":1.1,"adc1":2891,"adc2":2882,"io_caused":7,"power":25763,"gsm_operator":21601,"vod":1}},{"tp":"ud","pos":{"y":47.0992833333,"x":17.546715,"z":230,"s":0,"c":83,"sc":8},"i":0,"lc":0,"p":{"hdop":1.1,"adc1":2891,"adc2":2882,"io_caused":7,"power":25763,"gsm_operator":21601,"vod":1}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "render/3$rname"
	fi

#delete messages
params="\{\"layerName\":\"message_layer1\",\"msgIndex\":0,\"unitId\":$ucid\}"
resp=`curl -s "$server?svc=render/delete_message&params=$params&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "render/4$rname"
	fi

#delete layer
params="\{\}"
resp=`curl -s "$server?svc=render/remove_all_layers&params=$params&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "render/5$rname"
	fi

#core/delete_item
	dresp=`curl -s "$server?svc=item/delete_item&params=\{\"itemId\":$ucid\}&sid=$sid"`
	#echo $dresp