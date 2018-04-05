#!/bin/bash
. ../lib.sh

#create notification
params='{"n":"'$rname'","ta":1487192400,"td":0,"tz":134228528,"la":"en","ma":0,"sch":{"f1":0,"f2":0,"t1":0,"t2":0,"m":0,"y":0,"w":0,"fl":0},"un":['$unitId'],"trg":{"t":"speed","p":{"sensor_type":"","sensor_name_mask":"","lower_bound":0,"upper_bound":0,"merge":0,"min_speed":0,"max_speed":100}},"act":[{"t":"message","p":{"name":"'$rname'","url":"","color":"","blink":0}}],"txt":"'$rname'","fl":1,"mast":0,"mpst":0,"cdt":0,"mmtd":0,"cp":3600,"id":0,"itemId":'$itemId',"callMode":"create"}'
resp=`curl -s "$server?svc=resource/update_notification&sid=$sid" --data-urlencode "params=$params" | sed 's/"crc":[^"]*,//g'`
ct=`expr match "$resp" '.*"ct":\([0-9]*\).*'`
mt=`expr match "$resp" '.*"ct":\([0-9]*\).*'`
	#echo $resp
	mresp='[1,{"id":1,"n":"update_notification","txt":"'$rname'","ta":1487192400,"td":0,"ma":0,"fl":1,"ac":0,"un":['$unitId'],"act":["message"],"trg":"speed","trg_p":{"lower_bound":"0","max_speed":"100","merge":"0","min_speed":"0","sensor_name_mask":"","sensor_type":"","upper_bound":"0"},"ct":'$ct',"mt":'$mt'}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#get_notification_data
params='{"itemId":'$itemId',"col":[1],"flags":0}'
resp=`curl -s "$server?svc=resource/get_notification_data&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[{"id":1,"n":"'$rname'","txt":"'$rname'","ta":1487192400,"td":0,"ma":0,"mmtd":0,"cdt":0,"mast":0,"mpst":0,"cp":3600,"fl":1,"tz":134228528,"la":"en","ac":0,"sch":{"f1":0,"f2":0,"t1":0,"t2":0,"m":0,"y":0,"w":0,"fl":0},"ctrl_sch":{"f1":0,"f2":0,"t1":0,"t2":0,"m":0,"y":0,"w":0,"fl":0},"un":['$unitId'],"act":[{"t":"message","p":{"blink":"0","color":"","name":"'$rname'","url":""}}],"trg":{"t":"speed","p":{"lower_bound":"0","max_speed":"100","merge":"0","min_speed":"0","sensor_name_mask":"","sensor_type":"","upper_bound":"0"}},"ct":'$ct',"mt":'$ct'}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/$rname"
	fi

#delete_notification
params='{"itemId":'$itemId',"id":1,"callMode":"delete"}'
resp=`curl -s "$server?svc=resource/update_notification&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/$rname"
	fi