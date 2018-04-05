#!/bin/bash
. ../lib.sh
#create tag
params="\{\"c\":\"code\",\"ck\":0,\"ds\":\"desc\",\"id\":0,\"n\":\"$rname\",\"p\":\"\",\"r\":0,\"f\":0,\"pwd\":\"\",\"jp\":\{\},\"itemId\":$itemId,\"callMode\":\"create\"\}"
resp=`curl -s "$server?svc=resource/update_tag&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,{"id":1,"n":"update_tag_message","c":"code","jp":{},"r":0,"ck":0,"f":1,"bu":0,"pu":0,"bt":0,"tz":134228528,"pos":{"y":0,"x":0}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/1$rname"
	fi

#bind_tag
params="\{\"resourceId\":$itemId,\"tagId\":1,\"time\":$tf,\"unitId\":$unitId,\"mode\":true\}"
resp=`curl -s "$server?svc=resource/bind_unit_tag&params=$params&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/2$rname"
	fi

sleep 1

#get_tag_bindings
params="\{\"resourceId\":$itemId,\"unitId\":$unitId,\"tagId\":1,\"timeFrom\":0,\"timeTo\":2469796443\}"
resp=`curl -s "$server?svc=resource/get_tag_bindings&params=$params&sid=$sid"`
	#echo $resp
	mresp="{\"1\":[{\"t\":$tf,\"u\":$unitId,\"pu\":0,\"f\":0}]}"
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/3$rname"
	fi

#update_tag_message_unbind
params="\{\"resourceId\":$itemId,\"tagId\":1,\"time\":$tf,\"callMode\":\"update\",\"unitId\":0\}"
resp=`curl -s "$server?svc=resource/$rname&params=$params&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/4$rname"
	fi

sleep 1

#get_tag_bindings
params="\{\"resourceId\":$itemId,\"unitId\":$unitId,\"tagId\":1,\"timeFrom\":0,\"timeTo\":2469796443\}"
resp=`curl -s "$server?svc=resource/get_tag_bindings&params=$params&sid=$sid"`
	#echo $resp
	mresp="{\"1\":[{\"t\":$tf,\"u\":0,\"pu\":$unitId,\"f\":0}]}"
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/#16218$rname"
	fi	

#update_tag_message_bind
params="\{\"resourceId\":$itemId,\"tagId\":1,\"time\":$tf,\"callMode\":\"update\",\"unitId\":$unitId\}"
resp=`curl -s "$server?svc=resource/update_tag_message&params=$params&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/6$rname"
	fi

sleep 1

#get_tag_bindings
params="\{\"resourceId\":$itemId,\"unitId\":$unitId,\"tagId\":1,\"timeFrom\":0,\"timeTo\":2469796443\}"
resp=`curl -s "$server?svc=resource/get_tag_bindings&params=$params&sid=$sid"`
	#echo $resp
	mresp="{\"1\":[{\"t\":$tf,\"u\":$unitId,\"pu\":0,\"f\":0}]}"
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/7$rname"
	fi

#update_tag_message_delete
params="\{\"resourceId\":$itemId,\"tagId\":1,\"time\":$tf,\"callMode\":\"delete\"\}"
resp=`curl -s "$server?svc=resource/$rname&params=$params&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/8$rname"
	fi

sleep 1

#get_tag_bindings
params="\{\"resourceId\":$itemId,\"unitId\":$unitId,\"tagId\":1,\"timeFrom\":1469795835,\"timeTo\":2469796443\}"
resp=`curl -s "$server?svc=resource/get_tag_bindings&params=$params&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/9$rname"
	fi

#delete_tag
params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"delete\"\}"
resp=`curl -s "$server?svc=resource/update_tag&params=$params&sid=$sid"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/10$rname"
	fi	