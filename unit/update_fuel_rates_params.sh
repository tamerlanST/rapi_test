#!/bin/bash
. ../lib.sh

#unit/update_fuel_rates_params
	resp=`curl -s "$server?svc=unit/update_fuel_rates_params&params=\{\"itemId\":$unitId,\"idlingSummer\":0,\"idlingWinter\":0,\"consSummer\":11,\"consWinter\":12,\"winterMonthFrom\":11,\"winterDayFrom\":1,\"winterMonthTo\":1,\"winterDayTo\":30\}&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_fuel_rates_params"
	fi