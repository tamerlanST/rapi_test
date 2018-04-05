#!/bin/bash
. ../lib.sh
#render/set_locale
svc='render/set_locale'
params='{"tzOffset":134228528,"language":"ru","flags":0,"formatDate":"%Y-%m-%E%20%H:%M:%S"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi