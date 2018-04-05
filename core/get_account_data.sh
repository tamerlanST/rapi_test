#!/bin/bash
. ../lib.sh

#core/get_account_data
svc='core/get_account_data'
params='{"type":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"  | cut -c3-8`
	#echo $resp
	if [ "$resp" = "error" ];
		then error
	fi