#!/bin/bash
. ../lib.sh

#core/create_auth_hash
	authHash=`curl -s "$server?svc=core/create_auth_hash&params=\{\}&sid=$sid" | cut -c14-45`
	#echo $authHash

#item/use_auth_hash	
	svc='core/use_auth_hash'
	params='{"authHash":"'$authHash'"}'
	resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | grep -i -o '"eid"'`
	#echo $resp
	mresp='"eid"'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "core/$rname"
	fi

