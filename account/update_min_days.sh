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

#allow block by days (for update_min_days test)
svc='account/update_flags'
params='{"itemId":'$resourceId',"flags":32,"blockBalance":"0","denyBalance":"0"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# +1 min day
svc='account/update_min_days'
params='{"itemId":'$resourceId',"minDays":"1"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# get account history
svc='account/get_account_history'
params='{"itemId":'$resourceId',"days":"10","tz":134228528}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | cut -c1-1`
#echo $resp
	mresp='['
	#echo $mresp
	 if [ "$mresp" != "$resp" ];
	 	then error
	 fi

# update billing service
svc='account/update_billing_service'
params='{"itemId":'$resourceId',"name":"reportsmngt","type":1,"intervalType":0,"costTable":"-1"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# enable account
svc='account/enable_account'
params='{"itemId":'$resourceId',"enable":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

# enable dealer rights
svc='account/update_dealer_rights'
params='{"itemId":'$resourceId',"enable":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

#create billing plan if hosting - parrent is always Wialon Hosting Base, if local - $parrent.
svc='account/update_billing_plan'
params='{"callMode":"create","plan":{"name":"'$rname'","flags":0,"email":"","denyBalance":"0","blockBalance":"0","minDaysCounter":"0","currencyFormat":"","historyPeriod":65536,"descr":"","parent":"'$billingPlan'"}}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | cut -c1-9`
	#echo $resp
	mresp='{"parent"'
 	#echo $mresp
 	if [ "$mresp" != "$resp" ];
 		then error
 	fi	

# update sub plans
svc='account/update_sub_plans'
params='{"itemId":'$resourceId',"plans":["'$rname'"]}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# do payment
svc='account/do_payment'
params='{"itemId":'$resourceId',"balanceUpdate":1,"daysUpdate":0,"description":"'$rname'"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

# update history period
svc='account/update_history_period'
params='{"itemId":'$resourceId',"historyPeriod":50}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#delete account
svc='account/delete_account'
params='{"itemId":'$resourceId'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

#delete billing plan
svc='account/update_billing_plan'
params='{"callMode":"delete","plan":{"name":"'$rname'"}}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`	
	#echo $resp
	mresp="{}"
	#echo $mresp
 	if [ "$mresp" != "$resp" ];
 		then error
 	fi		