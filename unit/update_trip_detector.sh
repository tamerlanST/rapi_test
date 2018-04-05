#!/bin/bash
. ../lib.sh

#unit/update_trip_detector
svc='unit/update_trip_detector'
params='{"itemId":'$unitId',"type":1,"gpsCorrection":true,"minSat":2,"minMovingSpeed":2,"minStayTime":300,"maxMessagesDistance":10000,"minTripTime":60,"minTripDistance":100}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_trip_detector"
	fi

#unit/get_trip_detector
svc='unit/get_trip_detector'
params='{"itemId":'$unitId'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp									 
	mresp='{"type":1,"gpsCorrection":1,"minSat":2,"minMovingSpeed":2,"minStayTime":300,"maxMessagesDistance":10000,"minTripTime":60,"minTripDistance":100}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/get_trip_detector"
	fi
