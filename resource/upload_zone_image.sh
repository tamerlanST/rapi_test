#!/bin/bash
. ../lib.sh

#create_zone
params="\{\"n\":\"$rname\",\"d\":\"$rname\",\"t\":3,\"w\":10000,\"f\":32,\"c\":2568583984,\"tc\":16733440,\"ts\":12,\"min\":0,\"max\":18,\"libId\":\"\",\"path\":\"\",\"p\":\[\{\"x\":27.553024,\"y\":53.903687,\"r\":10000\}\],\"itemId\":$itemId,\"id\":0,\"callMode\":\"create\"\}"
resp=`curl -s "$server?svc=resource/update_zone&params=$params&sid=$sid"`
id=`expr match "$resp" '.*"id":\([0-9]*\).*'`
	#echo $resp
	mresp='['$id',{"n":"upload_zone_image","d":"upload_zone_image","id":'$id',"'
	#echo $mresp

	e1=`echo $resp | cut -c1-60`
	e2=`echo $mresp | cut -c1-60`

	if [ "$e1" != "$e2" ];
	 	then error "resource/$rname"
	fi

#upload_image
params="{\"itemId\":$itemId,\"id\":1}"
resp=`curl -sX POST -F "params=$params" -F "image=@1.jpg" "$server?svc=resource/$rname&sid=$sid"`
	#echo $resp
	mresp={}
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/$rname"
	fi

#reset_image
params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"reset_image\"\}"
resp=`curl -s "$server?svc=resource/update_zone&params=$params&sid=$sid" | cut -c1-60`
	#echo $resp
	mresp='[1,{"n":"upload_zone_image","d":"upload_zone_image","id":1,"'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/$rname"
	fi	

#delete_zone
params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"delete\"\}"
resp=`curl -s "$server?svc=resource/update_zone&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
	 	then error "resource/$rname"
	fi