#!/bin/bash
. ../lib.sh

#make
svc='item/update_profile_field'
params='{"itemId":'$unitId',"n":"vehicle_type","v":"value"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[1,{"id":1,"n":"vehicle_type","v":"value"}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "item/update_profile_field"
	fi

#clear
svc='item/update_profile_field'
params='{"itemId":'$unitId',"n":"vehicle_type","v":""}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "item/update_profile_field"
	fi