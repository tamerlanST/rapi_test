#!/bin/bash
. ../lib.sh

#unit/update_activity_settings
svc='unit/update_activity_settings'
params='{"itemId":'$unitId',"type":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`	
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#unit/get_activity_settings
svc='unit/get_activity_settings'
params='{"itemId":'$unitId'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"type":1}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	