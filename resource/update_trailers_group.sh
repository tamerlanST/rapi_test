#!/bin/bash
. ../lib.sh
params='{"id":0,"n":"'$rname'","d":"'$rname'","drs":[],"f":2,"itemId":'$itemId',"callMode":"create"}'
svc='resource/update_trailers_group'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='[1,{"id":1,"n":"update_trailers_group","d":"update_trailers_group","drs":[]}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/$rname"
	fi
params='{"itemId":'$itemId',"id":1,"callMode":"delete"}'
svc='resource/update_trailers_group'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/$rname"
	fi
