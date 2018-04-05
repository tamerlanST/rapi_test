#!/bin/bash
. ../lib.sh

#core/create_route
	svc='core/create_route'
	params='{"creatorId":'$uitemId',"name":"rapi_core/create_route","dataFlags":3845}'
	resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | sed 's/"cls":[^"]*,//g'`
	id=`echo $resp | jq '.item.id'`
	#echo $id
	#echo $resp 
	mresp='{"item":{"nm":"rapi_core\/create_route","id":'$id',"crt":'$uitemId',"bact":'$itemId',"mu":0,"rr":{},"rs":{},"rcfg":null,"rpts":[],"uacl":1114111},"flags":3845}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#item/delete_item
	svc='item/delete_item'
	params='{"itemId":'$id'}'
	resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
