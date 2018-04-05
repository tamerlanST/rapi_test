#!/bin/bash
. ../lib.sh

#unit/update_phone2
	resp=`curl -s "$server?svc=unit/update_phone2&params=\{\"itemId\":$unitId,\"phoneNumber\":\"%2B375111111112\"\}&sid=$sid"`
	#echo $resp 
	mresp='{"ph2":"+375111111112"}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_phone2"
	fi
