#!/bin/bash
. ../lib.sh

#item/update_name
svc='item/update_name'
params='{"itemId":'$unitId',"name":"test1"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp 
	mresp='{"nm":"test1"}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#item/update_name
svc='item/update_name'
params='{"itemId":'$unitId',"name":"test"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp 
	mresp='{"nm":"test"}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

