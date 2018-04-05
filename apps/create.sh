#!/bin/bash
. ../lib.sh

# Check rules
params='{}'
resp=`curl -s "$server?svc=apps/check_top_service&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"error":0}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "service is not TOP"
	fi

# Create APP
params='{"name":"test","description":"test","url":"//apps.wialon.com/tachomanager","flags":31,"langs":"ru,en","sortOrder":0,"requiredServicesList":"sdk","billingPlans":""}'
resp=`curl -s "$server?svc=apps/create&sid=$sid" --data-urlencode "params=$params"`
serviceName=`expr match "$resp" '.*"serviceName":"\([0-9_]*\).*'`
	echo $resp
	mresp='[1,{"name":"test","description":"test","url":"\/\/apps.wialon.com\/tachomanager","flags":31,"sortOrder":0,"serviceName":"'$serviceName'","id":1,"langs":"ru,en","requiredServicesList":"sdk","billingPlans":""}]'
	echo $mresp
	if [ "$mresp" != "$resp" ];
		then error 
	fi

# Update APP
params='{"id":1,"name":"test","description":"test","url":"//apps.wialon.com/tachomanager","flags":31,"langs":"","sortOrder":0,"requiredServicesList":"","billingPlans":""}'
resp=`curl -s "$server?svc=apps/update&sid=$sid" --data-urlencode "params=$params"`
	echo $resp
	mresp='[1,{"name":"test","description":"test","url":"\/\/apps.wialon.com\/tachomanager","flags":31,"sortOrder":0,"serviceName":"'$serviceName'","id":1,"langs":"","requiredServicesList":"","billingPlans":""}]'
	echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# APPs list
params='{"manageMode":0,"filterLang":""}'
resp=`curl -s "$server?svc=apps/list&sid=$sid" --data-urlencode "params=$params"`
	echo $resp
	mresp='[{"name":"test","description":"test","url":"\/\/apps.wialon.com\/tachomanager","flags":31,"sortOrder":0,"serviceName":"'$serviceName'"}]'
	echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# Delete APP
params='{"id":"1"}'
resp=`curl -s "$server?svc=apps/delete&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

