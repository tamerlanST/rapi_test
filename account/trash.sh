#!/bin/bash
. ../lib.sh

#50
params="\{\"callMode\":\"list\"\}"
resp=`curl -s "$server?svc=account/$rname&params=$params&sid=$sid" | cut -c1-18`
	#echo $resp
	mresp='{"code":0,"items":'
	local_mresp='{"error":6}'
	#echo $mresp
	#echo $local_mresp
	if [[ "$resp" != "$mresp" && "$resp" != "$local_mresp" ]];
		then error
	fi

	