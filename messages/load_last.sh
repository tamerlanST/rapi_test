#!/bin/bash
. ../lib.sh

# get last log messages
svc='messages/load_last'
params='{"itemId":'$unitId',"lastTime":'$tm',"lastCount":100,"flags":4096,"flagsMask":65280,"loadCount":50}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | cut -c1-9`
	#echo $resp
	mresp='{"count":'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi