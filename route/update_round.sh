#!/bin/bash
#created by pash
. ../lib.sh
unixtime=`date +%s`

#core/create_route
params='{"creatorId":'$uitemId',"name":"rapiroute","dataFlags":3845}'
resp=`curl -sX GET --data-urlencode "params=$params" "$server?svc=core/create_route&sid=$sid" | sed 's/"cls":[^"]*,//g'`
routeId=`expr match "$resp" '.*"id":\([0-9]*\).*'`
#echo $resp
#echo $routeId
mresp='{"item":{"nm":"rapiroute","id":'$routeId',"crt":'$uitemId',"bact":'$itemId',"mu":0,"rr":{},"rs":{},"rcfg":null,"rpts":[],"uacl":1114111},"flags":3845}'
#echo $mresp
if [ "$mresp" != "$resp" ];
    then error "route/1$rname"
#else echo "success1"
fi

#update checkpoints
params="\{\"itemId\":$routeId,\"checkPoints\":\[\{\"f\":1,\"n\":\"point1\",\"y\":53.67068019347264,\"x\":27.685546875000004,\"r\":100\}%2C\{\"f\":1,\"n\":\"point2\",\"y\":53.67068089347264,\"x\":27.685541875000004,\"r\":100\}%2C\{\"f\":4,\"n\":\"point3\",\"u\":$unitId,\"r\":100\}\]\}"
#echo $params
resp=`curl -s "$server?svc=route/update_checkpoints&params=$params&sid=$sid"`

#echo $resp
mresp='{"rpts":[{"n":"point1","f":1,"u":0,"y":53.6706801935,"x":27.685546875,"r":100},{"n":"point2","f":1,"u":0,"y":53.6706808935,"x":27.685541875,"r":100},{"n":"","f":4,"u":'$unitId',"y":0,"x":0,"r":100}]}'
     

if [ "$mresp" != "$resp" ];
		then error "route/2$rname"
	#else echo "success2"
	fi

#create schedule
params="\{\"n\":\"rapisched1\",\"f\":1,\"tz\":134228528,\"u\":$unitId,\"tm\":\[\{\"at\":100,\"ad\":10,\"dt\":200,\"dd\":10\}%2C\{\"at\":300,\"ad\":10,\"dt\":400,\"dd\":10\}%2C\{\"at\":500,\"ad\":10,\"dt\":600,\"dd\":10\}\],\"sch\":\{\"f1\":0,\"f2\":0,\"t1\":0,\"t2\":0,\"m\":0,\"y\":0,\"w\":0\},\"cfg\":\{\"name\":\"sched\",\"units\":\[\],\"enabled\":0,\"roundFlags\":2,\"autoName\":1,\"validityPeriod\":86400\},\"itemId\":$routeId,\"id\":0,\"callMode\":\"create\"\}"
#echo $params
resp=`curl -s "$server?svc=route/update_schedule&params=$params&sid=$sid"`

#echo $resp
mresp='[1,{"id":1,"n":"rapisched1","f":1,"tz":134228528,"cfg":{"autoName":1,"enabled":0,"name":"sched","roundFlags":2,"units":[],"validityPeriod":86400},"tm":[{"at":100,"ad":10,"dt":200,"dd":10},{"at":300,"ad":10,"dt":400,"dd":10},{"at":500,"ad":10,"dt":600,"dd":10}],"sch":{"f1":0,"f2":0,"t1":0,"t2":0,"m":0,"y":0,"w":0,"fl":0}}]'

if [ "$mresp" != "$resp" ];
		then error "route/3$rname"
	#else echo "success3"
	fi


#create round
params="\{\"n\":\"round1\",\"d\":\"test\",\"u\":$unitId,\"at\":$unixtime,\"vt\":$unixtime,\"vp\":86400,\"sh\":1,\"cu\":\[$unitId\],\"f\":2,\"tz\":134228528,\"itemId\":$routeId,\"id\":0,\"callMode\":\"create\"\}"
#echo $params
resp=`curl -s "$server?svc=route/update_round&params=$params&sid=$sid" | sed 's/"vt":[^"]*,//g' | sed 's/"at":[^"]*,//g'`

#echo $resp
mresp='[1,{"id":1,"n":"round1","d":"test","sh":"rapisched1","f":2,"tz":134228528,"u":'$unitId',"vp":86400,"sts":0,"st":{"st":{"pi":0,"ps":0,"ut":0},"pts":{}}}]'
if [ "$mresp" != "$resp" ];
		then error "route/4$rname"
	#else echo "success4"
	fi

#update config
params="\{\"itemId\":$routeId,\"config\":\{\"color\":16711680,\"descr\":\"test\",\"units\":\[$unitId\]\}\}"
#echo $params
resp=`curl -s "$server?svc=route/update_config&params=$params&sid=$sid"`

#echo $resp
mresp='{"rcfg":{"color":16711680,"descr":"test","units":['$unitId']}}'
if [ "$mresp" != "$resp" ];
	then error "route/5$rname"
	#else echo "success5"
fi

#get_round data
params="\{\"itemId\":$routeId,\"col\":\[1\]\}"
resp=`curl -s "$server?svc=route/get_round_data&params=$params&sid=$sid" | sed 's/"vt":[^"]*,//g' | sed 's/"at":[^"]*,//g'`
	#echo $resp
	mresp='[{"id":1,"n":"round1","d":"test","tz":134228528,"u":'$unitId',"cu":['$unitId'],"pt":[{"n":"point1","f":1,"u":0,"y":53.6706801935,"x":27.685546875,"r":100},{"n":"point2","f":1,"u":0,"y":53.6706808935,"x":27.685541875,"r":100},{"n":"","f":4,"u":'$unitId',"y":0,"x":0,"r":100}],"sh":{"id":0,"n":"rapisched1","f":1,"tz":134228528,"cfg":{"autoName":1,"enabled":0,"name":"sched","roundFlags":2,"units":[],"validityPeriod":86400},"tm":[{"ad":10,"dt":200,"dd":10},{"ad":10,"dt":400,"dd":10},{"ad":10,"dt":600,"dd":10}],"sch":{"f1":0,"f2":0,"t1":0,"t2":0,"m":0,"y":0,"w":0,"fl":0}},"vp":86400,"f":2,"st":{"st":{"pi":0,"ps":0,"ut":0},"pts":{}}}]'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi

#get all rounds
params="\{\"itemId\":$routeId,\"timeFrom\":0,\"timeTo\":$unixtime,\"fullJson\":0\}"
resp=`curl -s "$server?svc=route/get_all_rounds&params=$params&sid=$sid" | sed 's/"vt":[^"]*,//g' | sed 's/"at":[^"]*,//g'`
	#echo $resp
	mresp='{"actual":[{"id":1,"n":"round1","d":"test","sh":"rapisched1","f":2,"tz":134228528,"u":'$unitId',"vp":86400,"sts":0,"st":{"st":{"pi":0,"ps":0,"ut":0},"pts":{}}}],"history":[],"virtual":[]}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi


#get schedule time
params="\{\"itemId\":$routeId,\"scheduleId\":1,\"timeFrom\":0,\"timeTo\":1980413447\}"
#echo $params
resp=`curl -s "$server?svc=route/get_schedule_time&params=$params&sid=$sid"`

#echo $resp
mresp='[]'
if [ "$mresp" != "$resp" ];
		then error "route/8$rname"
	#else echo "success8"
	fi

#load_rounds
params="\{\"itemId\":$routeId,\"timeFrom\":0,\"timeTo\":$unixtime,\"fullJson\":0\}"
#echo $params
resp=`curl -s "$server?svc=route/load_rounds&params=$params&sid=$sid" | sed 's/"vt":[^"]*,//g' | sed 's/"at":[^"]*,//g'`

#echo $resp
mresp='[]'
if [ "$mresp" != "$resp" ];
		then error "route/9$rname"
	#else echo "success9"
	fi

#optimize
params="\{\"pathMatrix\":\[\[0%2C1%2C2\]%2C\[3%2C0%2C4\]%2C\[5%2C6%2C0\]\],\"pointSchedules\":\[\{\"from\":10,\"to\":100,\"waitInterval\":20\}%2C\{\"from\":200,\"to\":300,\"waitInterval\":20\}%2C\{\"from\":400,\"to\":500,\"waitInterval\":20\}\],\"flags\":1\}"
#echo $params
resp=`curl -s "$server?svc=route/optimize&params=$params&sid=$sid"`

#echo $resp
mresp='{"success":1,"order":[{"tm":600,"tmf":"00:10","id":0},{"tm":12000,"tmf":"03:20","id":1},{"tm":24000,"tmf":"06:40","id":2}]}'
if [ "$mresp" != "$resp" ];
		then error "route/10$rname"
	#else echo "success10"
	fi

#item/delete_item
	dresp=`curl -s "$server?svc=item/delete_item&params=\{\"itemId\":$routeId\}&sid=$sid"`
	#echo $dresp
	mresp='{}'
if [ "$mresp" != "$dresp" ];
		then error "route/11$rname"
	#else echo "success11"
	fi

