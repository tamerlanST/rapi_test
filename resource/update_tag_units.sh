#!/bin/bash
. ../lib.sh

#update_tag_units
resp=`curl -s "$server?svc=resource/$rname&params=\{\"itemId\":$itemId,\"units\":\[$unitId\]\}&sid=$sid"`
	#echo $resp
	mresp='{"tagrun":['$unitId']}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi