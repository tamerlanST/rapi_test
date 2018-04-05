#!/bin/bash
. ../lib.sh

#unit/registry_custom_event
	resp=`curl -s "$server?svc=unit/registry_custom_event&params=\{\"date\":1459089360,\"x\":0,\"y\":0,\"description\":\"123\",\"violation\":0,\"itemId\":$unitId\}&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/registry_custom_event"
	fi

