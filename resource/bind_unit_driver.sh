#!/bin/bash
. ../lib.sh

#create driver
params="\{\"c\":\"code\",\"ck\":0,\"ds\":\"desc\",\"id\":0,\"n\":\"$rname\",\"p\":\"\",\"r\":0,\"f\":0,\"pwd\":\"\",\"jp\":\{\},\"itemId\":$itemId,\"callMode\":\"create\"\}"
resp=`curl -s "$server?svc=resource/update_driver&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,{"id":1,"n":"bind_unit_driver","c":"code","jp":{},"ej":{},"pwd":"","ds":"desc","p":"","r":0,"f":1,"ck":0,"bu":0,"pu":0,"bt":0,"bs":0,"pos":{"y":0,"x":0}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/1$rname"
	fi

#bind_driver
params="\{\"resourceId\":$itemId,\"driverId\":1,\"time\":$tf,\"unitId\":$unitId,\"mode\":true\}"
resp=`curl -s "$server?svc=resource/$rname&params=$params&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/2$rname"
	fi

sleep 1

#unbind_driver
params="\{\"resourceId\":$itemId,\"driverId\":1,\"time\":$tt,\"unitId\":$unitId,\"mode\":false\}"
resp=`curl -s "$server?svc=resource/$rname&params=$params&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/3$rname"
	fi

sleep 1

#get_driver_bindings
params="\{\"resourceId\":$itemId,\"unitId\":$unitId,\"driverId\":1,\"timeFrom\":1369795835,\"timeTo\":2469796443\}"
resp=`curl -s "$server?svc=resource/get_driver_bindings&params=$params&sid=$sid"`
	#echo $resp
	mresp="{\"1\":[{\"t\":$tf,\"u\":$unitId},{\"t\":$tt,\"u\":0}]}"
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/4$rname"
	fi

#cleanup_driver_interval
params="\{\"resourceId\":$itemId,\"driverId\":1,\"timeFrom\":$tf,\"timeTo\":$tf\}"
resp=`curl -s "$server?svc=resource/cleanup_driver_interval&params=$params&sid=$sid"`
	#echo $resp
	mresp=\{\}
	#echo $mresp
	if [ "$mresp" != "$resp" ];
	 	then error "resource/5$rname"
	fi

#delete_driver
params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"delete\"\}"
resp=`curl -s "$server?svc=resource/update_driver&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/6$rname"
	fi	