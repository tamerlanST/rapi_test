#!/bin/bash
. ../lib.sh

params="\{\"n\":\"$rname\",\"d\":\"$rname\",\"t\":3,\"w\":10000,\"f\":32,\"c\":2568583984,\"tc\":16733440,\"ts\":12,\"min\":0,\"max\":18,\"libId\":\"\",\"path\":\"\",\"p\":\[\{\"x\":27.553024,\"y\":53.903687,\"r\":10000\}\],\"itemId\":$itemId,\"id\":0,\"callMode\":\"create\"\}"
resp=`curl -s "$server?svc=resource/$rname&params=$params&sid=$sid" | cut -c1-60`
#echo $resp
	mresp='[1,{"n":"update_zone","d":"update_zone","id":1,"f":48,"t":3,'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
	 	then error "resource/$rname"
	fi

params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"delete\"\}"
resp=`curl -s "$server?svc=resource/$rname&params=$params&sid=$sid"`
#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
	 	then error "resource/$rname"
	fi