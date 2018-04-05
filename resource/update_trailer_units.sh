#!/bin/bash
. ../lib.sh

#resource/update_trailer_units
svc='resource/update_trailer_units'
params='{"itemId":'$itemId',"units":['$unitId']}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"trlrun":['$unitId']}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
