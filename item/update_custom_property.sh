#!/bin/bash
. ../lib.sh

#item/update_custom_property
svc='item/update_custom_property'
params='{"itemId":'$uitemId',"name":"vasya","value":"kolya"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp 												  
	mresp='{"n":"vasya","v":"kolya"}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
