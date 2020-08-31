#!/bin/bash

TERM1=$1
TERM2=$2
TERM3=$3

# TODO: use awk with formatting

echo
cat ~/.bash_history | grep -T -E "pytest.*$TERM1.*$TERM2.*$TERM3"
echo


