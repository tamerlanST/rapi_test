#!/bin/bash
. ../lib.sh

# create driver
params='{"c":"code","ck":0,"ds":"desc","id":0,"n":"'$rname'","p":"","r":0,"f":0,"pwd":"","jp":{},"itemId":'$itemId',"callMode":"create"}'
resp=`curl -s "$server?svc=resource/update_driver&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[1,{"id":1,"n":"update_driver","c":"code","jp":{},"ej":{},"pwd":"","ds":"desc","p":"","r":0,"f":1,"ck":0,"bu":0,"pu":0,"bt":0,"bs":0,"pos":{"y":0,"x":0}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# update_driver
params='{"c":"0000000027544000","ck":0,"ds":"desc_u","id":1,"n":"u'$rname'","p":"","r":0,"f":0,"pwd":"","jp":{"u":"u"},"itemId":'$itemId',"callMode":"update"}'
resp=`curl -s "$server?svc=resource/update_driver&sid=$sid" --data-urlencode "params=$params"`	
	#echo $resp
	mresp='[1,{"id":1,"n":"uupdate_driver","c":"0000000027544000","jp":{"u":"u"},"ej":{},"pwd":"","ds":"desc_u","p":"","r":0,"f":1,"ck":0,"bu":0,"pu":0,"bt":0,"bs":0,"pos":{"y":0,"x":0}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# upload_driver_image
params='{"itemId":'$itemId',"driverId":1}'
resp=`curl -sX POST -F "params=$params" -F "image=@1.jpg" "$server?svc=resource/upload_driver_image&sid=$sid"`
#echo $resp
	mresp={}
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/3$rname"
	fi

# upload_tacho_file
params='{"outputFlag":1,"eventHash":"jUploadForm'$tm'"}'
resp=`curl -sX POST -F "params=$params" -F "image=@MIKALAI_STSEPANOVICH_2015-02-03_13-20-36__50799.ddd" "$server?svc=resource/upload_tacho_file&sid=$sid"`
serviceName=`expr match "$resp" '.*"serviceName":"\([0-9_]*\).*'`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error 
	fi

# check_event_guid
resp=`curl -s "$site/avl_evts?sid=$sid"`
event_tm=`expr match "$resp" '.*"tm":\([0-9]*\).*'`
guid=`expr match "$resp" '.*"guid":"\([a-z0-9]*\).*'`
	#echo $resp
	mresp='{"tm":'$event_tm',"events":[{"i":-1,"d":{"hash":"jUploadForm'$tm'","result":{"svc_error": 0, "svc_result": {"guid":"'$guid'", "parseResult": {"dc":"0000000027544000","c":"Belarus","an":"Transportnaya inspectsia","dn":"M_STSEPANOVICH","id":1343606400,"vb":1343606400,"ed":1501372799,"fa":1387497600,"la":1422954840,"vl":["E997AX777","H837YP197RUS"]}}}}}]}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error 
	fi

# bind_file_to_driver
params='{"itemId":'$itemId',"driverCode":"0000000027544000","guid":"'$guid'","outputFlag":5}'
resp=`curl -s "$server?svc=resource/upload_tacho_file&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{"dc":"0000000027544000","c":"Belarus","an":"Transportnaya inspectsia","dn":"M_STSEPANOVICH","id":1343606400,"vb":1343606400,"ed":1501372799,"fa":1387497600,"la":1422954840,"vl":["E997AX777","H837YP197RUS"]}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# delete_driver
params='{"itemId":'$itemId',"id":1,"callMode":"delete"}'
resp=`curl -s "$server?svc=resource/update_driver&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# delete_ddd_file
method='file/rm'
params='{"itemId":'$itemId',"storageType":2,"path":"tachograph/0000000027544000_1387497600_1422954840_M_STSEPANOVICH.ddd"}'
resp=`curl -s "$server?svc=$method&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

















