#!/bin/bash

source ../lib.sh

################################
# Get report tables
################################

params='{}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/get_report_tables&lang=ru&sid=$sid"`

# Check is error
if [ "${response:0:8}" == '{"error"' ]; then
    error "Report creation error - $response";
fi