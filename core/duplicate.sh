#!/bin/bash
. ../lib.sh

#item/use_auth_hash	
svc='core/duplicate'
params='{"operateAs":"'$childusername'"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | grep -i -o '"eid"'`																												 
	#echo $resp
	mresp='"eid"'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
