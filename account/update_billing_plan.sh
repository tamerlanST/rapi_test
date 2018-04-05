#!/bin/bash
. ../lib.sh

#create_child_user
svc=core/create_user
params='{"creatorId":'$uitemId',"name":"'$rname'","password":"child","dataFlags":5}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | sed 's/"crt":[^"]*,//g' | sed 's/"bact":[^"]*,//g'`
userId=`echo $resp | jq '.item.id'`
#echo userId=$userId
#echo $resp
	mresp='{"item":{"nm":"'$rname'","cls":1,"id":'$userId',"mu":0,"uacl":32571391},"flags":5}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#create resource
svc='core/create_resource'
params='{"creatorId":'$userId',"name":"'$rname'","skipCreatorCheck":0,"dataFlags":5}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | sed 's/"bact":[^"]*,//g'`
resourceId=`echo $resp | jq '.item.id'`
#echo resourceId=$resourceId
#echo $resp
	mresp='{"item":{"nm":"'$rname'","cls":3,"id":'$resourceId',"crt":'$userId',"mu":0,"bpact":0,"uacl":60610577498111},"flags":5}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#create account
svc='account/create_account'
params='{"itemId":'$resourceId',"plan":"'$billingPlan'"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#create billing plan if hosting - parrent is always Wialon Hosting Base, if local - $parrent.
params='{"callMode":"create","plan":{"name":"'$rname'","flags":0,"email":"","denyBalance":"0","blockBalance":"0","minDaysCounter":"0","currencyFormat":"","historyPeriod":65536,"descr":"","parent":"'$billingPlan'"}}'
resp=`curl -s "$server?svc=account/$rname&sid=$sid" --data-urlencode "params=$params" | cut -c1-9`
	#echo $resp
	mresp='{"parent"'
 	#echo $mresp
 	if [ "$mresp" != "$resp" ];
 		then error "account/$rname"
 	fi		   

#change billing plan
params="\{\"itemId\":$resourceId,\"plan\":\"$rname\"\}"
resp=`curl -s "$server?svc=account/update_plan&params=$params&sid=$sid"`
#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "account/$rname"
	fi

#delete account
svc='account/delete_account'
params='{"itemId":'$resourceId'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $params
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi		

#delete billing plan
params='{"callMode":"delete","plan":{"name":"'$rname'"}}'
resp=`curl -s "$server?svc=account/$rname&sid=$sid" --data-urlencode "params=$params"`	
	#echo $resp
	mresp="{}"
	#echo $mresp
 	if [ "$mresp" != "$resp" ];
 		then error
 	fi		