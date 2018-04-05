#!/bin/bash
. ../lib.sh

#на американскую систему мер
svc='item/update_measure_units'
params='{"itemId":'$unitId',"type":1,"flags":0}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp 												     
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#обратно
svc='item/update_measure_units'
params='{"itemId":'$unitId',"type":0,"flags":0}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp 												     
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi