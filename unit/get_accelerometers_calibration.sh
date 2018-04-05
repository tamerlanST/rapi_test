#!/bin/bash
. ../lib.sh

# get calibration
svc='unit/get_accelerometers_calibration'
params='{"itemId":'$unitId'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"error":0}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# reset calibr
svc='unit/update_accelerometers_calibration'
params='{"itemId":'$unitId',"reset":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"error":0}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi