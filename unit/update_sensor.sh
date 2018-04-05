#!/bin/bash
. ../lib.sh

#create_sensor
svc='unit/update_sensor'
params='{"n":"name","t":"custom","d":"","m":"","p":"time","f":0,"c":"{\"appear_in_popup\":true,\"show_time\":false,\"pos\":1,\"ci\":{},\"cm\":0,\"validate_driver_unbound\":0,\"unbound_code\":\"\",\"mu\":\"0\",\"act\":1,\"text_params\":0,\"uct\":0,\"timeout\":0}","vt":1,"vs":0,"tbl":[],"id":0,"itemId":'$unitId',"callMode":"create"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp									 
	mresp='[1,{"id":1,"n":"name","t":"custom","d":"","m":"","p":"time","f":0,"c":"{\"act\":1,\"appear_in_popup\":true,\"ci\":{},\"cm\":0,\"mu\":\"0\",\"pos\":1,\"show_time\":false,\"text_params\":0,\"timeout\":0,\"uct\":0,\"unbound_code\":\"\",\"validate_driver_unbound\":0}","vt":1,"vs":0,"tbl":[]}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#delete_sensor
svc='unit/update_sensor'
params='{"itemId":'$unitId',"id":1,"callMode":"delete"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp									 
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
