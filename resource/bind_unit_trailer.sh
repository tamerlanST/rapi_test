#!/bin/bash
. ../lib.sh

#create trailer
params="\{\"c\":\"code\",\"ck\":0,\"ds\":\"desc\",\"id\":0,\"n\":\"$rname\",\"p\":\"\",\"r\":0,\"f\":0,\"pwd\":\"\",\"jp\":\{\},\"itemId\":$itemId,\"callMode\":\"create\"\}"
resp=`curl -s "$server?svc=resource/update_trailer&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,{"id":1,"n":"bind_unit_trailer","c":"code","jp":{},"ej":{},"pwd":"","ds":"desc","p":"","r":0,"f":2,"ck":0,"bu":0,"pu":0,"bt":0,"bs":0,"pos":{"y":0,"x":0}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#bind_trailer
params="\{\"resourceId\":$itemId,\"trailerId\":1,\"time\":$tf,\"unitId\":$unitId,\"mode\":true\}"
resp=`curl -s "$server?svc=resource/$rname&params=$params&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

sleep 1

#unbind_trailer
params="\{\"resourceId\":$itemId,\"trailerId\":1,\"time\":$tt,\"unitId\":$unitId,\"mode\":false\}"
resp=`curl -s "$server?svc=resource/$rname&params=$params&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

sleep 1

#get_trailer_bindings
params="\{\"resourceId\":$itemId,\"unitId\":$unitId,\"trailerId\":1,\"timeFrom\":1369795835,\"timeTo\":2469796443\}"
resp=`curl -s "$server?svc=resource/get_trailer_bindings&params=$params&sid=$sid"`
	#echo $resp
	mresp="{\"1\":[{\"t\":$tf,\"u\":$unitId},{\"t\":$tt,\"u\":0}]}"
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#cleanup_trailer_interval
params="\{\"resourceId\":$itemId,\"trailerId\":1,\"timeFrom\":$tf,\"timeTo\":$tf\}"
resp=`curl -s "$server?svc=resource/cleanup_trailer_interval&params=$params&sid=$sid"`
	#echo $resp
	mresp=\{\}
	#echo $mresp
	if [ "$mresp" != "$resp" ];
	 	then error
	fi

#delete_trailer
params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"delete\"\}"
resp=`curl -s "$server?svc=resource/update_trailer&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	