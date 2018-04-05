#!/bin/bash
. ../lib.sh

#unit/update_mileage_counter
	resp=`curl -s "$server?svc=unit/update_mileage_counter&params=\{\"itemId\":$unitId,\"newValue\":50\}&sid=$sid"`
	#echo $resp
	mresp='{"cnm":50}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_mileage_counter"
	fi
