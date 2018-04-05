#!/bin/bash
. ../lib.sh

svc='resource/update_zone'
params='{"n":"'$rname'","d":"'$rname'","t":3,"w":10000,"f":32,"c":2568583984,"tc":16733440,"ts":12,"min":0,"max":18,"libId":"","path":"","p":[{"x":27.553024,"y":53.903687,"r":10000}],"itemId":'$itemId',"id":0,"callMode":"create"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | cut -c1-74`
#echo $resp
	mresp='[1,{"n":"get_zones_by_point","d":"get_zones_by_point","id":1,"f":48,"t":3,'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
	 	then error "resource/1$rname"
	fi

svc='resource/get_zones_by_point'
params='{"spec":{"zoneId":{"'$itemId'":[1]},"lat":53.90,"lon":27.55}}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='{"'$itemId'":[1]}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
	 	then error "resource/2$rname"
	fi

svc='resource/update_zone'
params='{"itemId":'$itemId',"id":1,"callMode":"delete"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
	 	then error "resource/3$rname"
	fi