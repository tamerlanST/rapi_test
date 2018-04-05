#!/bin/bash
. ../lib.sh

#update_image
svc='unit/update_image'
params='{"itemId":'$unitId',"libId":0,"path":"library/unit/s_z_29.svg"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`	
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
