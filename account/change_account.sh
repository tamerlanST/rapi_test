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

#core/get_hw_types
svc='core/get_hw_types'
params='{"filterType":"name","filterValue":["ATrack"],"includeType":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
hwid=`echo $resp | jq '.[]' | jq '.id'`
#echo $hwid
#echo $resp
	mresp='[{"id":'$hwid',"uid2":1,"name":"ATrack","hw_category":"auto","tp":"20219","up":"20219"}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

#core/create_unit
svc='core/create_unit'
params='{"creatorId":'$uitemId',"name":"'$rname'","hwTypeId":'$hwid',"dataFlags":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
unitId=`echo $resp | jq '.item.id'`
#echo $resp
	mresp='{"item":{"nm":"'$rname'","cls":2,"id":'$unitId',"mu":0,"uacl":880333094911},"flags":1}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#granting access to migrate
params='{"userId":'$userId',"itemId":'$unitId',"accessMask":76546061}'
svc='user/update_item_access'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi


#user/get_items_access
params='{"userId":'$userId',"directAccess":0,"itemSuperclass":"avl_unit","flags":3}'
svc='user/get_items_access'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
mresp='{"'$unitId'":{"cacl":76546061,"dacl":76546061}}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#check item access
params='{"units":['$unitId']}'
svc='account/list_change_accounts'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
mresp='[{"id":'$resourceId',"name":"'$rname'"}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#migrate
svc='account/change_account'
params='{"itemId":'$unitId',"resourceId":'$resourceId'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#get account data
params='{"itemId":'$resourceId',"type":4}'
svc='account/get_account_data'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params" | cut -c3-8`
#echo $resp
	if [ "$resp" = "error" ];
		then error
	fi

#core/delete_item
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




