#!/bin/bash
. ../lib.sh

#core/create_user
params='{"creatorId":'$uitemId',"name":"core_create_user","password":"stan","dataFlags":1}'
resp=`curl -s "$server?svc=core/create_user&sid=$sid" --data-urlencode "params=$params"`
id=`expr match "$resp" '.*"id":\([0-9]*\).*'`
	#echo $resp
	mresp='{"item":{"nm":"core_create_user","cls":1,"id":'$id',"mu":0,"uacl":32571391},"flags":1}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#add hosts mask
params="\{\"userId\":$id,\"hostsMask\":\"192.168.1.*\"\}"
resp=`curl -s "$server?svc=user/update_hosts_mask&params=$params&sid=$sid"`
#echo $resp
mresp='{"hm":"192.168.1.*"}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#remove hosts mask
params="\{\"userId\":$id,\"hostsMask\":\"\"\}"
resp=`curl -s "$server?svc=user/update_hosts_mask&params=$params&sid=$sid"`
#echo $resp
mresp='{"hm":""}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# user/update_pass (can change pass of sub user)
svc='user/update_password'
params='{"userId":'$id',"oldPassword":"","newPassword":"12345"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# user/update_password (old password can't be empty)
svc='user/update_password'
params='{"userId":'$uitemId',"oldPassword":"","newPassword":"12345"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"error":6, "reason":"SET_PASSWORD_FAILED"}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

# user/update_password ({"error":6, "reason":"PASSWORD_STRONG_FAILED: lenght should not be less than 4"})
svc='user/update_password'
params='{"userId":'$uitemId',"oldPassword":"rapi","newPassword":""}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"error":6, "reason":"PASSWORD_STRONG_FAILED: lenght should not be less than 4"}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

# update child user flags + sms
svc='user/update_user_flags'
params='{"userId":'$id',"flags":32,"flagsMask":32}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"fl":32}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# update child user flags -sms
svc='user/update_user_flags'
params='{"userId":'$id',"flags":0,"flagsMask":32}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"fl":0}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

# update self user flags -sms
svc='user/update_user_flags'
params='{"userId":'$uitemId',"flags":0,"flagsMask":32}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"error":7}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi		

#add user notification
params="\{\"h\":\"$rname\",\"d\":\"$rname\",\"s\":\"\",\"ttl\":1367295558,\"itemId\":$id,\"id\":0,\"callMode\":\"create\"\}"
resp=`curl -s "$server?svc=user/update_user_notification&params=$params&sid=$sid" | cut -c1-11`
#echo $resp
mresp='[1,{"id":1,'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# delete user notification	
resp=`curl -s "$server?svc=user/update_user_notification&params=\{\"itemId\":$id,\"id\":1,\"callMode\":\"delete\"\}&sid=$sid"`	
#echo $resp
mresp='[1,null]'
	if [ "$mresp" != "$resp" ];
		then error
	fi

#core/delete_user
	resp=`curl -s "$server?svc=item/delete_item&params=\{\"itemId\":$id\}&sid=$sid"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi