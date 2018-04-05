#!/bin/bash
. ../lib.sh

#unit/update_service_interval
svc='unit/update_service_interval'
params='{"c":0,"id":0,"ie":2,"im":100,"it":10,"n":"name","pe":1,"pm":50,"pt":'$tm',"t":"name","itemId":'$unitId',"callMode":"create"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[1,{"id":1,"n":"name","t":"name","im":100,"it":10,"ie":2,"pm":50,"pt":'$tm',"pe":1,"c":0}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

svc='unit/update_service_interval'
params='{"itemId":'$unitId',"id":1,"callMode":"delete"}	'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
