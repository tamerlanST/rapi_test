#!/bin/bash
. ../lib.sh

#create
svc='token/update'
params='{"callMode":"create","app":"wialon","at":0,"dur":10,"fl":-1,"p":"{}","items":[]}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | sed 's/"at":[^"]*,//g' | sed 's/"ct":[^"]*,//g'`
token=`echo $resp | jq '.["h"]'`
	#echo $token
	#echo $resp
	mresp='{"h":'$token',"app":"wialon","dur":10,"fl":-1,"items":[],"p":"{}"}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "token/$rname"
	fi

#list
svc='token/list'
params='{}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | cut -c1-6`
	#echo $resp
	mresp='[{"h":'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "token/list"
	fi

#delete
params='{"callMode":"delete","h":'$token'}'
svc='token/update'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
 	#echo $resp
 	mresp='{}'
 	#echo $mresp
 	if [ "$mresp" != "$resp" ];
 		then error "token/$rname"
 	fi