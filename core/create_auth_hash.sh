#!/bin/bash
. ../lib.sh

#item/create_auth_hash
	resp=`curl -s "$server?svc=core/create_auth_hash&params=\{\}&sid=$sid" | sed 's/:"[^"]*"//g'`
	#echo $resp
	 #| cut -c14-45
	mresp='{"authHash"}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "item/create_auth_hash"
	fi

