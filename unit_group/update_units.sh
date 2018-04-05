#!/bin/bash
. ../lib.sh
#create_unit_group
params='{"creatorId":'$uitemId',"name":"'$rname'","dataFlags":1}'
resp=`curl -s "$server?svc=core/create_unit_group&sid=$sid" --data-urlencode "params=$params"`
id=`expr match "$resp" '.*"id":\([0-9]*\).*'`
	#echo $resp
	mresp='{"item":{"nm":"update_units","cls":5,"id":'$id',"mu":0,"u":[],"uacl":880333094911},"flags":1}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit_group/$rname"
	fi

#update_units
params='{"itemId":'$id',"units":['$unitId']}'
resp=`curl -s "$server?svc=unit_group/$rname&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
 	mresp='{"u":['$unitId']}'
	#echo $mresp
 	if [ "$mresp" != "$resp" ];
 		then error "unit_group/$rname"
 	fi

#delete_group
params='{"itemId":'$id'}'
resp=`curl -s "$server?svc=item/delete_item&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp 	
	mresp='{}'
	#echo $mresp
 	if [ "$mresp" != "$resp" ];
 		then error "unit_group/$rname"
 	fi