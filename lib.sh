#!/bin/bash

config_file='../config.sh'

if [ -f "$config_file" ]; then 
    . $config_file
  else
    echo "make config_file"
fi

sid=`curl -s "$server?svc=token/login&params=\{\"token\":\"$token\"\}" | jq '.["eid"]' | cut -c2-33`
#echo $sid

# Names of executable files
rname=`basename ${0%.*}`
fname=`echo "$PWD" | rev | cut -d"/" -f1 | rev`

#times ...
tm=`date +%s`

let "tf = `date +%s` - 110" #used in bind_unit_*
let "tt = `date +%s` - 10"
let "tff = $tf - 10"
let "ttt = $tt + 10"

error () {
    echo "$fname/$rname: line $BASH_LINENO: "${1:-"Unknown error"}
}
