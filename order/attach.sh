#!/bin/bash
#created by pash
. ../lib.sh
unixtime=`date +%s`

#echo $sid

#create order
params="\{\"uid\":1,\"id\":0,\"n\":\"11qwertydp2021\",\"p\":\{\"n\":\"\",\"e\":\"\",\"a\":\"\",\"v\":0,\"w\":0,\"c\":0,\"d\":\"\",\"ut\":600,\"t\":\"\",\"r\":null,\"cid\":\"\",\"uic\":\"\",\"ntf\":0,\"pr\":0,\"tags\":\[\]\},\"f\":1,\"tf\":$unixtime,\"tt\":1680058368,\"r\":100,\"y\":53.67068019347264,\"x\":27.685546875000004,\"u\":0,\"trt\":3600,\"itemId\":$itemId,\"callMode\":\"create\",\"dp\":\"\[12\]\"\}"
resp=`curl -s "$server?svc=order/update&params=$params&sid=$sid" | sed 's/"uid":[^"]*,//g' | sed 's/"tf":[^"]*,//g' | sed 's/"tt":[^"]*,//g'`
	#echo $resp
	mresp='[1,{"id":1,"n":"11qwertydp2021","f":1,"trt":3600,"r":100,"y":53.6706809998,"x":27.685546875,"u":0,"s":0,"sf":0,"st":0,"cnm":0,"if":0,"nt":0,"stt":0,"dtt":0,"eta":0,"rd":0,"ds":0,"p":{"a":"","c":0,"cid":"","d":"","e":"","n":"","ntf":0,"pr":0,"r":null,"t":"","tags":[],"uic":"","ut":600,"v":0,"w":0},"ej":{},"dp":[12],"tz":134228528,"rp":""}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#attach image
params="{\"itemId\":$itemId,\"id\":1,\"eventHash\":\"imagename11\"}"
resp=`curl -sX POST -F "params=$params" -F "image=@1.jpg" "$server?svc=order/attach&sid=$sid"`
	#echo $resp
	mresp='{"error":0}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#list of attachments
params="\{\"itemId\":$itemId,\"id\":1\}"
#echo $unixtime
resp=`curl -s "$server?svc=order/list_attachments&params=$params&sid=$sid" | cut -c1-25`
#echo $resp
mresp='[{"n":"1.jpg","s":104805,'
		if [ "$mresp" != "$resp" ];
		then error
		fi

#get attach
params="\{\"itemId\":$itemId,\"id\":1,\"path\":\"1.jpg\"\}"
#resp=`curl -s --compressed "$server?svc=order/get_attachment&params=$params&sid=$sid"` 
curl -sX GET "$server?svc=order/get_attachment&params=$params&sid=$sid" > 2.jpg
resp=`diff 1.jpg 2.jpg`
#echo $resp 
mresp=""

if [  "$mresp" != "$resp"  ];
		then error
	fi	
	rm 2.jpg	   
	
#detach image
params="\{\"itemId\":$itemId,\"id\":1,\"path\":\"1.jpg\"\}"
resp=`curl -s "$server?svc=order/detach&params=$params&sid=$sid"`
#echo $resp
mresp={}

if [ "$mresp" != "$resp" ];
		then error
	fi

#delete order
params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"delete\"\}"
resp=`curl -s "$server?svc=order/update&params=$params&sid=$sid"`
#echo $resp
mresp='[1,null]'

if [ "$mresp" != "$resp" ];
		then error
	fi
	
