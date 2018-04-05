#!/bin/bash
. ../lib.sh

#unit/registry_status_event
	resp=`curl -s "$server?svc=unit/registry_status_event&params=\{\"date\":1459089360,\"description\":\"123\",\"itemId\":$unitId\}&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/registry_status_event"
	fi

