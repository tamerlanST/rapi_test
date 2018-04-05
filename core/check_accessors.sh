#!/bin/bash
. ../lib.sh

#core/check_accessors
svc='core/check_accessors'
params='{"items":['$unitId'],"flags":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi