#!/bin/bash
. ../lib.sh

#unit/update_traffic_counter
	resp=`curl -s "$server?svc=unit/update_traffic_counter&params=\{\"itemId\":$unitId,\"newValue\":2,\"regReset\":0\}&sid=$sid"`
	#echo $resp
	mresp='{"cnkb":2}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_traffic_counter"
	fi