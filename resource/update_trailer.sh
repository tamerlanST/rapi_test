#!/bin/bash
. ../lib.sh

#create trailer
params="\{\"c\":\"code\",\"ck\":0,\"ds\":\"desc\",\"id\":0,\"n\":\"$rname\",\"p\":\"\",\"r\":0,\"f\":0,\"pwd\":\"\",\"jp\":\{\},\"itemId\":$itemId,\"callMode\":\"create\"\}"
resp=`curl -s "$server?svc=resource/update_trailer&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,{"id":1,"n":"update_trailer","c":"code","jp":{},"ej":{},"pwd":"","ds":"desc","p":"","r":0,"f":2,"ck":0,"bu":0,"pu":0,"bt":0,"bs":0,"pos":{"y":0,"x":0}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#update_trailer
params="\{\"c\":\"code_u\",\"ck\":0,\"ds\":\"desc_u\",\"id\":1,\"n\":\"u$rname\",\"p\":\"\",\"r\":0,\"f\":0,\"pwd\":\"\",\"jp\":\{\"u\":\"u\"\},\"itemId\":$itemId,\"callMode\":\"update\"\}"
resp=`curl -s "$server?svc=resource/$rname&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,{"id":1,"n":"uupdate_trailer","c":"code_u","jp":{"u":"u"},"ej":{},"pwd":"","ds":"desc_u","p":"","r":0,"f":2,"ck":0,"bu":0,"pu":0,"bt":0,"bs":0,"pos":{"y":0,"x":0}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#upload_image
params="{\"itemId\":$itemId,\"trailerId\":1}"
resp=`curl -sX POST -F "params=$params" -F "image=@1.jpg" "$server?svc=resource/upload_trailer_image&sid=$sid"`
	#echo $resp
	mresp={}
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#reset_image
params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"reset_image\"\}"
resp=`curl -s "$server?svc=resource/update_trailer&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,{"id":1,"n":"uupdate_trailer","c":"code_u","jp":{"u":"u"},"ej":{},"pwd":"","ds":"desc_u","p":"","r":0,"f":2,"ck":0,"bu":0,"pu":0,"bt":0,"bs":0,"pos":{"y":0,"x":0}}]'
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