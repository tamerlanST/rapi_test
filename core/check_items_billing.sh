#!/bin/bash
. ../lib.sh
#item/check_items_billing
svc='core/check_items_billing'
params='{"items":['$child_accId'],"serviceName":"drivers","accessFlags":33554432}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='['$child_accId']'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
