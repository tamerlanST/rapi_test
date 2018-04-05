#!/bin/bash
. ../lib.sh

#create custom_field
svc='item/update_custom_field'
params='{"itemId":'$unitId',"id":0,"callMode":"create","n":"test","v":"test"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[1,{"id":1,"n":"test","v":"test"}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#update custom_field
svc='item/update_custom_field'
params='{"itemId":'$unitId',"id":1,"callMode":"update","n":"test1","v":"test1"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[1,{"id":1,"n":"test1","v":"test1"}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

#delete custom_field
svc='item/update_custom_field'
params='{"itemId":'$unitId',"id":1,"callMode":"delete"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi