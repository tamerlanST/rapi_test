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

# core/create_unit
svc='core/create_unit'
params='{"creatorId":'$uitemId',"name":"calc_sensors","hwTypeId":'$hwid',"dataFlags":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
id=`echo $resp | jq '.item.id'`
	#echo $id
    #echo $resp
	mresp='{"item":{"nm":"calc_sensors","cls":2,"id":'$id',"mu":0,"uacl":880333094911},"flags":1}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# create sensor
svc='unit/update_sensor'
params='{"n":"1","t":"custom","d":"","m":"","p":"adc2","f":0,"c":"{\"appear_in_popup\":true,\"show_time\":false,\"pos\":1,\"ci\":{},\"cm\":0,\"validate_driver_unbound\":0,\"unbound_code\":\"\",\"mu\":\"0\",\"act\":1,\"text_params\":0,\"uct\":0,\"timeout\":0}","vt":1,"vs":0,"tbl":[],"id":0,"itemId":'$id',"callMode":"create"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
    #echo $resp
	mresp='[1,{"id":1,"n":"1","t":"custom","d":"","m":"","p":"adc2","f":0,"c":"{\"act\":1,\"appear_in_popup\":true,\"ci\":{},\"cm\":0,\"mu\":\"0\",\"pos\":1,\"show_time\":false,\"text_params\":0,\"timeout\":0,\"uct\":0,\"unbound_code\":\"\",\"validate_driver_unbound\":0}","vt":1,"vs":0,"tbl":[]}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# import message
svc='exchange/import_messages'
params='{"itemId":'$id',"eventHash":"fish"}'	  
echo "REG;2489127050;15.4128837585;48.1832389832;0;0;ALT:244.0,hdop:1.0,odo:0.0,adc2:100.0,adc12:27598.0;;;;;" > wln.wln
resp=`curl -sX POST -F "params=$params" -F "filename=@wln.wln" "$server?svc=$svc&sid=$sid"`
rm wln.wln
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

sleep 1

# load_interval
svc='messages/load_interval'
params='{"itemId":'$id',"timeFrom":1332795600,"timeTo":2490648399,"flags":0,"flagsMask":65280,"loadCount":50}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | cut -c1-9`
	#echo $resp
	mresp='{"count":'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# calc sensors
svc='unit/calc_sensors'
params='{"source":"","indexFrom":0,"indexTo":10,"unitId":'$id',"sensorId":0}'	  
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[{"1":100}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#get_trips
svc='unit/get_trips'
params='{"itemId":'$id',"msgsSource":1,"timeFrom":1,"timeTo":2490648399}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# delete unit
svc='item/delete_item'
params='{"itemId":'$id'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
