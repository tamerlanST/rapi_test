#!/bin/bash
. ../lib.sh

#unit/update_command_definition (Create command)
svc='unit/update_command_definition'
params='{"id":0,"n":"cmd","c":"custom_msg","l":"","p":"","a":1,"f":"0","itemId":'$unitId',"callMode":"create"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
id=`echo $resp| jq '.[1].id'`
#echo $id
	#echo $resp
	mresp='['$id',{"id":'$id',"n":"cmd","c":"custom_msg","l":"","p":"","a":1,"f":0}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#unit/update_command_definition
svc='unit/update_command_definition'
params='{"id":'$id',"n":"updated_cmd","c":"custom_msg","l":"","p":"","a":32768,"f":"0","itemId":'$unitId',"callMode":"update"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='['$id',{"id":'$id',"n":"updated_cmd","c":"custom_msg","l":"","p":"","a":32768,"f":0}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

# unit/get_command_definition_data (check WTF is the command)
svc='unit/get_command_definition_data'
params='{"itemId":'$unitId',"col":['$id']}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[{"id":'$id',"n":"updated_cmd","c":"custom_msg","l":"","p":"","a":32768,"f":0}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

# unit/get_command_definition_data (check WTF is the command)
svc='unit/exec_cmd'
params='{"itemId":'$unitId',"commandName":"updated_cmd","linkType":"","param":"11111","timeout":60,"flags":0}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi	

#unit/update_command_definition
svc='unit/update_command_definition'
params='{"itemId":'$unitId',"id":'$id',"callMode":"delete"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='['$id',null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
