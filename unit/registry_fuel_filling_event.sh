#!/bin/bash
. ../lib.sh

#unit/registry_fuel_filling_event
	resp=`curl -s "$server?svc=unit/registry_fuel_filling_event&params=\{\"date\":1459089360,\"volume\":100,\"cost\":0,\"location\":\"\",\"deviation\":30,\"x\":0,\"y\":0,\"description\":\"filling\",\"itemId\":$unitId\}&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/registry_fuel_filling_event"
	fi

