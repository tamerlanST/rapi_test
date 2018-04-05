#!/bin/bash
. ../lib.sh

#create order
params="\{\"uid\":1,\"id\":0,\"n\":\"11qwertydp2021\",\"p\":\{\"n\":\"\",\"e\":\"\",\"a\":\"adress\",\"v\":0,\"w\":0,\"c\":0,\"d\":\"\",\"ut\":600,\"t\":\"\",\"r\":null,\"cid\":\"\",\"uic\":\"\",\"ntf\":0,\"pr\":0,\"tags\":\[\]\},\"f\":1,\"tf\":1478725200,\"tt\":1478811540,\"r\":100,\"y\":53.67068019347264,\"x\":27.685546875000004,\"u\":0,\"trt\":3600,\"itemId\":$itemId,\"callMode\":\"create\",\"dp\":\"\[12\]\"\}"
resp=`curl -s "$server?svc=order/update&params=$params&sid=$sid" | sed 's/"uid":[^"]*,//g'`
	#echo $resp
	mresp='[1,{"id":1,"n":"11qwertydp2021","f":1,"tf":1478725200,"tt":1478811540,"trt":3600,"r":100,"y":53.6706809998,"x":27.685546875,"u":0,"s":0,"sf":0,"st":0,"cnm":0,"if":0,"nt":0,"stt":0,"dtt":0,"eta":0,"rd":0,"ds":0,"p":{"a":"adress","c":0,"cid":"","d":"","e":"","n":"","ntf":0,"pr":0,"r":null,"t":"","tags":[],"uic":"","ut":600,"v":0,"w":0},"ej":{},"dp":[12],"tz":134228528,"rp":""}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#update order
params="\{\"uid\":1,\"id\":1,\"n\":\"11qwertydp21\",\"p\":\{\"n\":\"\",\"e\":\"\",\"a\":\"adress\",\"v\":0,\"w\":0,\"c\":0,\"d\":\"\",\"ut\":600,\"t\":\"\",\"r\":null,\"cid\":\"\",\"uic\":\"\",\"ntf\":0,\"pr\":0,\"tags\":\[\]\},\"f\":1,\"tf\":1478725200,\"tt\":1478811540,\"r\":100,\"y\":53.67068019347264,\"x\":27.685546875000004,\"u\":0,\"trt\":3600,\"itemId\":$itemId,\"callMode\":\"update\",\"dp\":\"\[12\]\"\}"
resp=`curl -s "$server?svc=order/update&params=$params&sid=$sid" | sed 's/"uid":[^"]*,//g'`
	#echo $resp
	mresp='[1,{"id":1}]'
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
	