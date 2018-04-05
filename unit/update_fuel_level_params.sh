#!/bin/bash
. ../lib.sh

#unit/update_fuel_level_params
svc='unit/update_fuel_level_params'
params='{"itemId":'$unitId',"flags":1,"ignoreStayTimeout":20,"minFillingVolume":20,"minTheftTimeout":0,"minTheftVolume":10,"filterQuality":0,"fillingsJoinInterval":300,"theftsJoinInterval":300,"extraFillingTimeout":0}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#unit/get_fuel_settings
svc='unit/get_fuel_settings'
params='{"itemId":'$unitId'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"calcTypes":16,"fuelLevelParams":{"flags":1,"ignoreStayTimeout":20,"minFillingVolume":20,"minTheftTimeout":0,"minTheftVolume":10,"filterQuality":0,"fillingsJoinInterval":300,"theftsJoinInterval":300,"extraFillingTimeout":0},"fuelConsMath":{"idling":2,"urban":10,"suburban":7},"fuelConsRates":{"consSummer":11,"consWinter":12,"winterMonthFrom":11,"winterDayFrom":1,"winterMonthTo":1,"winterDayTo":30},"fuelConsImpulse":{"maxImpulses":5,"skipZero":1}}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	