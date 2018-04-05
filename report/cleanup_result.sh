#!/bin/bash
source ../lib.sh

method='report/cleanup_result'

# Params list
params="{}"

# Execute command and compare with equivalent
response=`curl -sd "svc=$method&params=$params&sid=$sid" "$server"`

# Testing equivalent
equivalent='{"error":0}'

# Execution
if [ "$equivalent" != "$response" ]; then
    error "$response isn't compare with $equivalent"
fi