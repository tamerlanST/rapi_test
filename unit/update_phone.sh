#!/bin/bash
. ../lib.sh

#unit/update_phone1
	resp=`curl -s "$server?svc=unit/update_phone&params=\{\"itemId\":$unitId,\"phoneNumber\":\"%2B375111111111\"\}&sid=$sid"`
	#echo $resp 
	mresp='{"ph":"+375111111111"}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_phone"
	fi
