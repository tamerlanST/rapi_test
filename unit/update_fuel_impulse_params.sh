#!/bin/bash
. ../lib.sh

#unit/update_fuel_impulse_params
	resp=`curl -s "$server?svc=unit/update_fuel_impulse_params&params=\{\"itemId\":$unitId,\"maxImpulses\":5,\"skipZero\":1\}&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_fuel_impulse_params"
	fi