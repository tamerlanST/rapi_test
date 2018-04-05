#!/bin/bash
. ../lib.sh

#update_drive_rank_settings
svc='unit/update_drive_rank_settings'
params='{"itemId":'$unitId',"driveRank":{"speeding":[{"flags":0,"name":"Скорость","penalties":1}],"global":{"accel_mode":"0"}}}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi


#get_drive_rank_settings
svc='unit/get_drive_rank_settings'
params='{"itemId":'$unitId'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"global":{"accel_mode":"0"},"speeding":[{"flags":0,"name":"Скорость","penalties":1}]}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
