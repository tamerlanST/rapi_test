#!/bin/bash
. ../lib.sh

#core/login
resp=`curl -s "$server?svc=core/logout&params=\{\}&sid=$sid"`
#echo $resp
mresp={\"error\":0}
#echo $mresp
if [ "$mresp" != "$resp" ];
	then error "core/logout"
fi



