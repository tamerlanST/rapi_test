#!/bin/bash

####################################################
# Check rapi_test dependencies
####################################################
deps=(jq curl diff)

for dep in ${deps[@]}; do
    which $dep > /dev/null
    if [ ! "$?" -eq 0 ]; then
        echo "Package '${dep}' is not installed";
        exit 1;
    fi
done

DIR_LIST=(apps account core item messages order render report resource retranslator route token unit unit_group user)

####################################################
# add directories with *.sh scripts in list above
####################################################
for folder in  "${DIR_LIST[@]}"
do
	cd $folder
	for file in `ls | grep .sh`
	do
		#echo $file
		bash $file
	done
	cd ..
done
exit 77

