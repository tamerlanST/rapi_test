#!/bin/bash
. ../lib.sh

#unit/update_eh_counter
	resp=`curl -s "$server?svc=unit/update_eh_counter&params=\{\"itemId\":$unitId,\"newValue\":1\}&sid=$sid"`
	#echo $resp
	mresp='{"cneh":1}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_eh_counter"
	fi
