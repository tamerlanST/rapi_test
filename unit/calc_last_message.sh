#!/bin/bash
. ../lib.sh

#unit/calc_last_message
	resp=`curl -s "$server?svc=unit/calc_last_message&params=\{\"unitId\":$unitId,\"sensors\":\[1\]\}&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/calc_last_message"
	fi
