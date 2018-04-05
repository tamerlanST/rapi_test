#!/bin/bash
. ../lib.sh


# load_interval
svc='messages/load_interval'
params='{"itemId":'$unitId',"timeFrom":1332795600,"timeTo":2490648399,"flags":4096,"flagsMask":65280,"loadCount":50}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | cut -c1-9`
	#echo $resp
	mresp='{"count":'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#get messages
svc='messages/get_messages'
params='{"indexFrom":9,"indexTo":10}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | cut -c1-6`
	#echo $resp
	mresp='[{"t":'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#delete message
svc='messages/delete_message'
params='{"msgIndex":0}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

# unload inteval
svc='messages/unload'
params='{}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi