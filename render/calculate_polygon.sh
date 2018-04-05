#!/bin/bash
#created by pash
. ../lib.sh
unixtime=`date +%s`

#echo $sid

#calculate_polygon
params="\{\"p\":\[\{\"x\":50.23378676427059,\"y\":38.40703130037091\}%2C\{\"x\":50.23318676427059,\"y\":38.40103130037091\}%2C\{\"x\":52.23318676427059,\"y\":36.40103130037091\}\],\"flags\":3\}"
resp=`curl -s "$server?svc=render/calculate_polygon&params=$params&sid=$sid"`

#echo $resp
mresp='{"area":65530416.705,"perimeter":569025.49682}'
#echo $mresp
if [ "$mresp" != "$resp" ];
		then error "render/1$rname"
		#else echo "success"
	fi


#calculate_polyline
params="\{\"p\":\[\{\"x\":50.23378676427059,\"y\":38.40703130037091\}%2C\{\"x\":50.23318676427059,\"y\":38.40103130037091\}%2C\{\"x\":52.23318676427059,\"y\":36.40103130037091\}\],\"flags\":3,\"w\":2\}"
resp=`curl -s "$server?svc=render/calculate_polyline&params=$params&sid=$sid"`

#echo $resp
mresp='{"area":569213.289148,"perimeter":284605.073778}'
#echo $mresp
if [ "$mresp" != "$resp" ];
		then error "render/2$rname"
		#else echo "success"
	fi

