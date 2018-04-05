#!/bin/bash
. ../lib.sh

# core/create_retranslator
params='{"creatorId":'$uitemId',"name":"'$rname'","config":{"protocol":"wialon","server":"","port":"20163","attach_sensors":"0","debug":"0"},"dataFlags":1}'
resp=`curl -sX GET --data-urlencode "params=$params" "$server?svc=core/$rname&sid=$sid" | sed 's/"cls":[^"]*,//g'`
id=`expr match "$resp" '.*"id":\([0-9]*\).*'`
    #echo $resp
    mresp='{"item":{"nm":"'$rname'","id":'$id',"mu":0,"uacl":3211263},"flags":1}'
    #echo $mresp
    if [ "$mresp" != "$resp" ];
        then error "core/$rname"
    fi

# retranslator/update_units
params='{"itemId":'$id',"units":[{"i":'$unitId',"a":"test"}]}'
svc='retranslator/update_units'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp 
	mresp='{"rtru":[{"i":'$unitId',"a":"test","st":0}]}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "retranslator/update_units"
	fi


# retranslator/update_config
params='{"itemId":'$id',"config":{"protocol":"wialon","server":"qa.test","port":"20163","attach_sensors":"0","debug":"0"}}'
svc='retranslator/update_config'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp 
	mresp='{"rtrc":{"attach_sensors":"0","debug":"0","port":"20163","protocol":"wialon","server":"qa.test"}}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "retranslator/update_config"
	fi	

# retranslator/update_operating
params='{"itemId":'$id',"operate":true}'
svc='retranslator/update_operating'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp 
	mresp="{\"rtro\":1,\"rtrst\":0}"
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "retranslator/update_operating"
	fi	

# retranslator/get_stats
params='{"itemId":'$id'}'
svc='retranslator/get_stats'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp 
	mresp='{"au":1,"ru":0,"hf":0,"hc":0,"ht":0,"hms":0,"hp":0}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "retranslator/get_stats"
	fi	

# item/delete_item
dresp=`curl -s "$server?svc=item/delete_item&params=\{\"itemId\":$id\}&sid=$sid"`
	#echo $dresp
	