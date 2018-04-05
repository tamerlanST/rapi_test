#!/bin/bash
. ../lib.sh

#core/reset_password_request
# есть таймаут, если запустить 2 раза подряд - будет валиться 11 ошибка, email пользователя должен быть валидным
svc='core/reset_password_request'
params='{"user":"'$childusername'","url":"valerka","email":"tamerlan90@tut.by","emailFrom":"antoha"}'
	resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp 											
	mresp='{"error":0}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi