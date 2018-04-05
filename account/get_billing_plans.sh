#!/bin/bash
. ../lib.sh
#disable
params="\{\}"
resp=`curl -s "$server?svc=account/$rname&params=$params&sid=$sid" | cut -c1-17`
#echo $resp
mresp='{"plan":{"parent"'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	