#!/bin/bash
. ../lib.sh

#unit/update_fuel_calc_types
	resp=`curl -s "$server?svc=unit/update_fuel_calc_types&params=\{\"itemId\":$unitId,\"calcTypes\":16\}&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi