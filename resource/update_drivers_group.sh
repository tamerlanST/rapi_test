#!/bin/bash
. ../lib.sh
params="\{\"id\":0,\"n\":\"$rname\",\"d\":\"$rname\",\"drs\":\[\],\"f\":2,\"itemId\":$itemId,\"callMode\":\"create\"\}"
resp=`curl -s "$server?svc=resource/update_drivers_group&params=$params&sid=$sid"`
#echo $resp
	mresp=[1,{\"id\":1,\"n\":\"update_drivers_group\",\"d\":\"update_drivers_group\",\"drs\":[]}]
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/$rname"
	fi
params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"delete\"\}"
resp=`curl -s "$server?svc=resource/update_drivers_group&params=$params&sid=$sid"`
#echo $resp
	mresp=[1,null]
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/$rname"
	fi
