#!/bin/bash
. ../lib.sh

#############################################
# core/update_data_flags delete from session
svc='core/update_data_flags'
params='{"spec":[{"type":"id","data":'$itemId',"flags":32,"mode":2}]}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# core/update_data_flags add to session
svc='core/update_data_flags'
params='{"spec":[{"type":"id","data":'$itemId',"flags":32,"mode":1}]}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[{"i":'$itemId',"d":{},"f":32}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi