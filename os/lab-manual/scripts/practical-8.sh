#!/bin/bash

THRESHOLD=80

# Print startup message
echo "Monitoring disk usage (Alert threshold: >= $THRESHOLD%)..."
echo "---------------------------------------------------------"

# Core Logic: One-liner using df and awk for maximum conciseness
# NR>1: Skips the header row
# $5+0: Implicitly converts the percentage string (e.g., "82%")
# to a number (82)
# -v t=$THRESHOLD: Passes the bash variable into awk

df -h | awk -v t="$THRESHOLD" 'NR>1 && $5+0 >= t {
    print "CRITICAL ALERT: Partition "$1" is at "$5" usage!"
}'
