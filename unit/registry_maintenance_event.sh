#!/bin/bash
. ../lib.sh

#unit/registry_maintenance_event
	resp=`curl -s "$server?svc=unit/registry_maintenance_event&params=\{\"date\":1459090200,\"info\":\"\",\"duration\":0,\"cost\":0,\"location\":\"\",\"x\":0,\"y\":0,\"description\":\"\",\"mileage\":0,\"eh\":0,\"done_svcs\":\"\",\"itemId\":$unitId\}&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/registry_maintenance_event"
	fi

