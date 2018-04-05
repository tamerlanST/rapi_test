#!/bin/bash
. ../lib.sh

RANGE=6
let "lucky = $RANDOM % $RANGE"
case "$lucky" in
  [0]   ) phoneNumber="+375293372522"; lucky="yami";;
  [1]   ) phoneNumber="+48784838928"; lucky="krir";;
  [2]   ) phoneNumber="+375293583009"; lucky="vele";;
  [3]   ) phoneNumber="+375293372522"; lucky="yami";;
  [4]   ) phoneNumber="+375291989293"; lucky="pash";;
  [5]   ) phoneNumber="+375295691347"; lucky="stan";;
esac

#generate compliment
compliment=`curl -s 'https://online-generators.ru/ajax.php' --data 'sex=0&type_compl=0&processor=compliments'  -H 'cookie: beget=begetok;' --insecure  | sed 's/##[0-9]*//g'`
	echo compliment: "$compliment" was send to $lucky

#test - stan number
#phoneNumber="+375296141308"

# send sms with compliment
svc='user/send_sms'
params='{"phoneNumber":"'$phoneNumber'","smsText":"'$compliment'"}'
resp=`curl -s "$server?svc=$svc&sid=$sid" --data-urlencode "params=$params"`
	#echo $resp
	mresp='{}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error
	fi
