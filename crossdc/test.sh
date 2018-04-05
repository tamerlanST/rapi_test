#!/bin/bash
error () {
    echo "$fname/$rname: line $BASH_LINENO: "${1:-"Unknown error"}
}
for i in {1..1}; do
	
sid='02a901852b482c5de8d3e00e29716b8d'
server='https://hst-api.wialon.com/wialon/ajax.html'
uitemId='852308'
#id='15629922'
hwid='34889'


# #core/get_hw_types
# svc='core/get_hw_types'
# params='{"filterType":"name","filterValue":["ATrack"],"includeType":1}'
# resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
# 	#echo $resp
# 	hwid=`echo $resp | jq '.[]' | jq '.id'`
# 	#echo $hwid
# 	mresp='[{"id":'$hwid',"uid2":1,"name":"ATrack","hw_category":"auto"}]'
# 	#echo $mresp
# 	if [ "$mresp" != "$resp" ];
# 		then error
# 	fi	

#core/create_unit
svc='core/create_unit'
params='{"creatorId":'$uitemId',"name":"crossdc","hwTypeId":'$hwid',"dataFlags":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
id=`echo $resp | jq '.item.id'`
    #echo $resp
	mresp='{"item":{"nm":"crossdc","cls":2,"id":'$id',"mu":0,"uacl":-1},"flags":1}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#update unit id
svc='unit/update_device_type'
params='{"itemId":'$id',"deviceTypeId":"'$hwid'","uniqueId":"crossdc"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	echo $resp
	mresp='{"uid":"crossdc","hw":'$hwid',"hwd":0}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
# update unit phone
"svc":"unit/update_phone","params":{"itemId":15681125,"phoneNumber":"+375295691347"}

# #update unit id
# svc='unit/update_device_type'
# params='{"itemId":'$id',"deviceTypeId":"'$hwid'","uniqueId":"crossdc1"}'
# resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
# 	echo $resp
# 	mresp='{"uid":"crossdc1","hw":'$hwid',"hwd":0}'
# 	#echo $mresp
# 	if [ "$mresp" != "$resp" ];
# 		then error
# 	fi	

#core/delete_item
svc='item/delete_item'
params='{"itemId":'$id'}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	


#########################################
#					MSK					#
#########################################

sid='21e829a9e37e9b3bb4cc0faaaaa5e94c'
server='https://hst-api.wialon.ru/wialon/ajax.html'
uitemId='200004975'
#id='200005572'
hwid='200003331'

# #core/get_hw_types
# svc='core/get_hw_types'
# params='{"filterType":"name","filterValue":["ATrack"],"includeType":1}'
# resp=`curl -s "$servermsk?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
# 	#echo $resp
# 	hwid=`echo $resp | jq '.[]' | jq '.id'`
# 	#echo $hwid
# 	mresp='[{"id":'$hwid',"uid2":1,"name":"ATrack","hw_category":"auto"}]'
# 	#echo $mresp
# 	if [ "$mresp" != "$resp" ];
# 		then error
# 	fi	

#core/create_unit
svc='core/create_unit'
params='{"creatorId":'$uitemId',"name":"crossdc","hwTypeId":'$hwid',"dataFlags":1}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
id=`echo $resp | jq '.item.id'`
    #echo $resp
	mresp='{"item":{"nm":"crossdc","cls":2,"id":'$id',"mu":0,"uacl":-1},"flags":1}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#update unit id
svc='unit/update_device_type'
params='{"itemId":'$id',"deviceTypeId":"'$hwid'","uniqueId":"crossdc"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	echo $resp	
	mresp='{"uid":"crossdc","hw":'$hwid',"hwd":0}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# #update unit id
# svc='unit/update_device_type'
# params='{"itemId":'$id',"deviceTypeId":"'$hwid'","uniqueId":"crossdc2"}'
# resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
# 	echo $resp
# 	mresp='{"uid":"crossdc2","hw":'$hwid',"hwd":0}'
# 	#echo $mresp
# 	if [ "$mresp" != "$resp" ];
# 		then error
# 	fi	

# #core/delete_item
# svc='item/delete_item'
# params='{"itemId":'$id'}'
# resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
# 	#echo $resp
# 	mresp='{}'
# 	#echo $mresp
# 	if [ "$mresp" != "$resp" ];
# 		then error
# 	fi	

done