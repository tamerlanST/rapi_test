#!/bin/bash

server='http://web.vps910.dnt-msq.gurtam.net/wialon/ajax.html'
sid='2cd132e07f616d6fbb0641f0b73544f0'
resourceId='13'
itemId='265'  #хз вообще что это за id такой, может ресурса, в котором геозону создавать

for i in {1..1000}; do

# create_plot
svc='agro/update_plot'
#params='{"id":0,"n":"test'$i'","d":"","pm":17155,"ar":1394.43,"uid":"2","zn":{"n":"test","t":2,"d":"","w":0,"f":0,"c":0,"p":[{"x":27.475964246751857,"y":53.98700468522141,"r":1},{"x":27.514416395183336,"y":53.942166975299706,"r":1},{"x":27.556301771154548,"y":53.99265646692183,"r":1}],"callMode":"create","itemId":'$itemId',"id":0},"clt":null,"itemId":'$resourceId',"callMode":"create"}'
params='{"id":0,"n":"test'$i'","d":"","pm":20384,"ar":1710.04,"uid":"2","zn":{"n":"test","t":2,"d":"","w":0,"f":0,"c":0,"p":[{"x":27.41988065123403,"y":53.92568225087867,"r":1},{"x":27.54073026059204,"y":53.92143667176595,"r":1},{"x":27.435330175157866,"y":53.88644475388084,"r":1}],"callMode":"create","itemId":265,"id":0},"clt":null,"itemId":'$resourceId',"callMode":"create"}'

resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
#echo $resp
id=`echo $resp | jq '.[]' | jq '.id' 2>/dev/null`
uid=`echo $resp | jq '.[]' | jq '.uid' 2>/dev/null`
ct=`echo $resp | jq '.[]' | jq '.ct' 2>/dev/null`
mt=`echo $resp | jq '.[]' | jq '.mt' 2>/dev/null`
	#echo $resp
	mresp='['$id',{"id":'$id',"uid":'$uid',"n":"test'$i'","d":"","ar":13944299.3361,"pm":17155.3380362,"hole":0,"zn":{"n":"test","d":"","id":0,"f":16,"t":2,"w":0,"e":26145,"c":0,"i":4294967295,"libId":0,"path":"","b":{"min_x":27.4759490181,"min_y":53.9421579917,"max_x":27.5563169998,"max_y":53.9926654505,"cen_x":27.516133009,"cen_y":53.9674117211},"ct":0,"mt":0},"clt":null,"ct":'$ct',"mt":'$mt'}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then 
		#echo "resource/1$rname"
		echo  "$id"
	fi
done	