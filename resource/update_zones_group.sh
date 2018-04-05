#!/bin/bash
. ../lib.sh
svc='resource/update_zones_group'
params='{"id":0,"n":"'$rname'","d":"'$rname'","zns":[],"f":2,"itemId":'$itemId',"callMode":"create"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='[1,{"id":1,"n":"update_zones_group","d":"update_zones_group","zns":[]}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

svc='resource/update_zones_group'	
params='{"itemId":'$itemId',"id":1,"callMode":"delete"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
 