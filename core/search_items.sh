#!/bin/bash
. ../lib.sh

#core/search_item
svc='core/search_items'
params='{"spec":{"itemsType":"avl_unit","propName":"sys_name","propValueMask":"test","sortType":"sys_name"},"force":1,"flags":261,"from":0,"to":19}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | sed 's/"crt":[^"]*,//g' | sed 's/"bact":[^"]*,//g' | sed 's/"hw":[^"]*,//g' | sed 's/"id":[^"]*,//g'`
id=`echo $resp | jq '.item.id'`
	#echo $resp
	mresp='{"searchSpec":{"itemsType":"avl_unit","propName":"sys_name","propValueMask":"test","sortType":"sys_name","propType":"","or_logic":"0"},"dataFlags":261,"totalItemsCount":1,"indexFrom":0,"indexTo":0,"items":[{"nm":"test","cls":2,"mu":0,"uid":"","uid2":"","ph":"+375111111111","ph2":"+375111111112","psw":"11111","act":1,"dactt":0,"uacl":880333094911}]}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi