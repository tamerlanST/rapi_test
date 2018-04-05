#!/bin/bash

source ../lib.sh


#report/update_report
svc='report/update_report'
params='{"n":"get_report_data","ct":"avl_unit","p":"{\"bind\":null}","tbl":[{"n":"unit_stats","l":"Статистика","f":0,"c":"","cl":"","p":"{\"address_format\":\"0_10_5\",\"time_format\":\"%E.%m.%Y_%H:%M:%S\",\"us_units\":0}","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Address\",\"Time Format\"]","s":"[\"address_format\",\"time_format\",\"us_units\"]"}],"id":0,"itemId":'$itemId',"callMode":"create"}'
resp=`curl -sX POST --data-urlencode "params=$params" "$server?svc=$svc&sid=$sid"`
reportId=`expr match "$resp" '.\([0-9]*\),'`	
	#echo $reportId	
	#echo $resp
	#mresp=
	#echo $mresp
	if [ "${resp:0:8}" == '{"error"' ]; then
    	error "Report creation error - $resp";
	fi

# report/get_report_data
svc='report/get_report_data'
params='{"itemId":'$itemId',"col":['$reportId']}'
resp=`curl -sX POST --data-urlencode "params=$params" "$server?svc=$svc&sid=$sid"`
	#echo $resp
	mresp='[{"id":'$reportId',"n":"get_report_data","ct":"avl_unit","p":"{\"bind\":null}","tbl":[{"n":"unit_stats","l":"Статистика","c":"","cl":"","cp":"","s":"[\"address_format\",\"time_format\",\"us_units\"]","sl":"[\"Address\",\"Time Format\"]","p":"{\"address_format\":\"0_10_5\",\"time_format\":\"%E.%m.%Y_%H:%M:%S\",\"us_units\":0}","sch":{"f1":0,"f2":0,"t1":0,"t2":0,"m":0,"y":0,"w":0,"fl":0},"f":0}]}]'
	#echo $mresp
	if [ "$resp" != "$mresp" ]; then
    	error
	fi

#delete report
svc='report/update_report'
params='{"id":'$reportId',"itemId":'$itemId',"callMode":"delete"}'
resp=`curl -sX POST --data-urlencode "params=$params" "$server?svc=$svc&sid=$sid"`
	#echo $resp
	mresp="[$reportId,null]"
	#echo $mresp
	if [ ${resp:0:8} == '{"error"' ]; then
    	error "Report delete error - $resp";
	elif [ "$resp" != "$mresp" ]; then
    	error "Can't delete report with id:$reportId"
	fi