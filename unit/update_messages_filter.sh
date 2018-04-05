#!/bin/bash
. ../lib.sh

#update_messages_filter
svc='unit/update_messages_filter'
params='{"itemId":'$unitId',"enabled":1,"skipInvalid":1,"minSats":5,"maxHdop":2,"maxSpeed":0,"lbsCorrection":0}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_messages_filter"
	fi

#get_messages_filter
svc='unit/get_messages_filter'
params='{"itemId":'$unitId'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"enabled":1,"skipInvalid":1,"minSats":5,"maxHdop":2,"maxSpeed":0,"lbsCorrection":0}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/get_messages_filter"
	fi	