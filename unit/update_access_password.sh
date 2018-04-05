#!/bin/bash
. ../lib.sh

#unit/update_access_password
	resp=`curl -s "$server?svc=unit/update_access_password&params=\{\"itemId\":$unitId,\"accessPassword\":\"11111\"\}&sid=$sid"`
	#echo $resp
	mresp='{"psw":"11111"}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_access_password"
	fi