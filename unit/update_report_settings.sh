#!/bin/bash
. ../lib.sh

#unit/update_report_settings
svc='unit/update_report_settings'
params='{"itemId":'$unitId',"params":{"urbanMaxSpeed":61}}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_report_settings"
	fi

#unit/get_report_settings
svc='unit/get_report_settings'
params='{"itemId":'$unitId'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"speedLimit":0,"maxMessagesInterval":0,"dailyEngineHoursRate":0,"urbanMaxSpeed":61,"mileageCoefficient":0,"fuelRateCoefficient":0,"speedingTolerance":10,"speedingMinDuration":1,"speedingMode":0}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/get_report_settings"
	fi
