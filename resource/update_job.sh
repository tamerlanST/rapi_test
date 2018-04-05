#!/bin/bash
. ../lib.sh

#create_job
params='{"n":"'$rname'","d":"descr","r":"2 7920","at":'$tf',"tz":134228528,"l":"ru","e":0,"m":0,"sch":{"f1":0,"f2":0,"t1":0,"t2":0,"m":0,"y":0,"w":0},"act":{"t":"reset_unit_mileage_counter","p":{"units":"'$unitId'","skip_reset":0,"store_mileage":1,"value_mileage":0,"param_name":"odometer"}},"id":0,"itemId":'$itemId',"callMode":"create"}'
resp=`curl -s "$server?svc=resource/$rname&sid=$sid" --data-urlencode "params=$params"`
ct=`expr match "$resp" '.*"ct":\([0-9]*\).*'`
mt=`expr match "$resp" '.*"ct":\([0-9]*\).*'`
	#echo $resp
	mresp='[1,{"id":1,"n":"'$rname'","d":"descr","m":0,"st":{"e":0,"c":0,"l":0},"act":"reset_unit_mileage_counter","ct":'$ct',"mt":'$mt'}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then if [ "$mresp1" != "$resp" ];
			then if [ "$mresp2" != "$resp" ];
				then error "resource/$rname"
			fi
		fi
	fi

#get_job_data
params='{"itemId":'$itemId',"col":[1],"flags":0}'
resp=`curl -s "$server?svc=resource/get_job_data&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[{"id":1,"n":"'$rname'","d":"descr","r":"2 7920","at":'$tf',"m":0,"fl":0,"tz":134228528,"l":"ru","st":{"e":0,"c":0,"l":0},"sch":{"f1":0,"f2":0,"t1":0,"t2":0,"m":0,"y":0,"w":0,"fl":0},"act":{"t":"reset_unit_mileage_counter","p":{"param_name":"odometer","skip_reset":"0","store_mileage":"1","units":"'$unitId'","value_mileage":"0"}},"ct":'$ct',"mt":'$mt'}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/$rname"
	fi

#delete_job
params='{"itemId":'$itemId',"id":1,"callMode":"delete"}'
resp=`curl -s "$server?svc=resource/$rname&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='[1,null]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "resource/$rname"
	fi

