#!/bin/bash
. ../lib.sh

#create tag
params="\{\"c\":\"code\",\"ck\":0,\"ds\":\"desc\",\"id\":0,\"n\":\"$rname\",\"p\":\"\",\"r\":0,\"f\":0,\"pwd\":\"\",\"jp\":\{\},\"itemId\":$itemId,\"callMode\":\"create\"\}"
resp=`curl -s "$server?svc=resource/update_tag&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,{"id":1,"n":"upload_tag_image","c":"code","jp":{},"r":0,"ck":0,"f":1,"bu":0,"pu":0,"bt":0,"tz":134228528,"pos":{"y":0,"x":0}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/1$rname"
	fi

#upload_image
params="{\"itemId\":$itemId,\"tagId\":1}"
resp=`curl -sX POST -F "params=$params" -F "image=@1.jpg" "$server?svc=resource/$rname&sid=$sid"`
	#echo $resp
	mresp={}
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/2$rname"
	fi

#reset_image
params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"reset_image\"\}"
resp=`curl -s "$server?svc=resource/update_tag&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,{"id":1,"n":"upload_tag_image","c":"code","jp":{},"r":0,"ck":0,"f":1,"bu":0,"pu":0,"bt":0,"tz":134228528,"pos":{"y":0,"x":0}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/3$rname"
	fi	

#delete_tag
params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"delete\"\}"
resp=`curl -s "$server?svc=resource/update_tag&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/4$rname"
	fi	