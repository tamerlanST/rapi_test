#!/bin/bash
. ../lib.sh
# user/update_locale
svc='user/update_locale'
params='{"userId":'$uitemId',"locale":{"fd":"%E %b %Y_%I:%M %p","wd":1}}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"locale":{"fd":"%E %b %Y_%I:%M %p","wd":1}}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# user/get_locale
svc='user/get_locale'
params='{"userId":'$uitemId'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"fd":"%E %b %Y_%I:%M %p","wd":1}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# user/update_locale to start
svc='user/update_locale'
params='{"userId":'$uitemId',"locale":{"fd":"%Y-%m-%E_%I:%M %p","wd":1}}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"locale":{"fd":"%Y-%m-%E_%I:%M %p","wd":1}}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi