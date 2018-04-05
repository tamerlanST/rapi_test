#!/bin/bash
. ../lib.sh

#core/search_item
svc='core/search_item'
params='{"id":'$unitId',"flags":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"item":{"nm":"test","cls":2,"id":'$unitId',"mu":0,"uacl":880333094911},"flags":1}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
