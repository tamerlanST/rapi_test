#!/bin/bash
. ../lib.sh

#create tag
params="\{\"c\":\"code\",\"ck\":0,\"ds\":\"desc\",\"id\":0,\"n\":\"$rname\",\"p\":\"\",\"r\":0,\"f\":0,\"pwd\":\"\",\"jp\":\{\},\"itemId\":$itemId,\"callMode\":\"create\"\}"
resp=`curl -s "$server?svc=resource/$rname&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,{"id":1,"n":"update_tag","c":"code","jp":{},"r":0,"ck":0,"f":1,"bu":0,"pu":0,"bt":0,"tz":134228528,"pos":{"y":0,"x":0}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/1$rname"
	fi

#update_tag
params="\{\"c\":\"code_u\",\"ck\":0,\"ds\":\"desc_u\",\"id\":1,\"n\":\"u$rname\",\"p\":\"\",\"r\":0,\"f\":0,\"pwd\":\"\",\"jp\":\{\"u\":\"u\"\},\"itemId\":$itemId,\"callMode\":\"update\"\}"
resp=`curl -s "$server?svc=resource/$rname&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,{"id":1,"n":"uupdate_tag","c":"code_u","jp":{"u":"u"},"r":0,"ck":0,"f":1,"bu":0,"pu":0,"bt":0,"tz":134228528,"pos":{"y":0,"x":0}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/2$rname"
	fi

#delete_tag
params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"delete\"\}"
resp=`curl -s "$server?svc=resource/$rname&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/3$rname"
	fi