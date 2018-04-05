#!/bin/bash
. ../lib.sh

#item/add_log_record
svc='item/add_log_record'
params='{"itemId":'$unitId',"action":"custom_msg","newValue":"add_log_record","oldValue":"add_log_record"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp 											
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
