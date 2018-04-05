#!/bin/bash
. ../lib.sh

#resource/update_driver_units
svc='resource/update_driver_units'
params='{"itemId":'$itemId',"units":['$unitId']}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='{"drvrun":['$unitId']}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi