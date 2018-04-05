#!/bin/bash
. ../lib.sh

#unit/update_calc_flags
	resp=`curl -s "$server?svc=unit/update_calc_flags&params=\{\"itemId\":$unitId,\"newValue\":17\}&sid=$sid"`
	#echo $resp
	mresp='{"cfl":17}'
	#echo $mresp
	if [ "$mresp" != "$resp" ];
		then error "unit/update_calc_flags"
	fi