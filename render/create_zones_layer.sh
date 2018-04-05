#!/bin/bash
#created by pash
. ../lib.sh
unixtime=`date +%s`

#echo $sid
#create zone
params="\{\"n\":\"$rname\",\"d\":\"$rname\",\"t\":3,\"w\":10000,\"f\":32,\"c\":2568583984,\"tc\":16733440,\"ts\":12,\"min\":0,\"max\":18,\"libId\":\"\",\"path\":\"\",\"p\":\[\{\"x\":27.553024,\"y\":53.903687,\"r\":10000\}\],\"itemId\":$itemId,\"id\":0,\"callMode\":\"create\"\}"
resp=`curl -s "$server?svc=resource/update_zone&params=$params&sid=$sid"`
#echo $resp

#create zone layer
params="\{\"layerName\":\"layer1\",\"flags\":1,\"zones\":\[\{\"resourceId\":$itemId,\"zoneId\":\[1\]\}\]\}"
#echo $params
resp=`curl -s "$server?svc=render/create_zones_layer&params=$params&sid=$sid"`

#echo $resp
mresp='{"name":"layer1","bounds":[53.903687,27.553024,53.903687,27.553024]}'
#echo $mresp
if [ "$mresp" != "$resp" ];
		then error "render/1$rname"
		#else echo "success"
	fi

#enable layer
params="\{\"layerName\":\"layer1\",\"enable\":1\}"
#echo $params
resp=`curl -s "$server?svc=render/enable_layer&params=$params&sid=$sid"`

#echo $resp
mresp='{"enabled":1}'
#echo $mresp
if [ "$mresp" != "$resp" ];
		then error "render/2$rname"
		#else echo "success"
	fi

#delete layer
params="\{\"layerName\":\"layer1\"\}"
#echo $params
resp=`curl -s "$server?svc=render/remove_layer&params=$params&sid=$sid"`

#echo $resp
mresp='{}'
#echo $mresp
if [ "$mresp" != "$resp" ];
		then error "render/3$rname"
		#else echo "success"
	fi

#delete zone
params="\{\"itemId\":$itemId,\"id\":1,\"callMode\":\"delete\"\}"
resp=`curl -s "$server?svc=resource/update_zone&params=$params&sid=$sid"`
#echo $resp