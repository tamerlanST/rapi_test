#!/bin/bash
. ../lib.sh

#unit/update_fuel_math_params
	resp=`curl -s "$server?svc=unit/update_fuel_math_params&params=\{\"itemId\":$unitId,\"idling\":2,\"urban\":10,\"suburban\":7,\"loadCoef\":1.3\}&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_fuel_math_params"
	fi