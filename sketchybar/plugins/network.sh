#!/bin/bash

network_in=$(netstat -bi | grep "en0" | awk '{print $7}')
network_out=$(netstat -bi | grep "en0" | awk '{print $10}')

echo "↓$(numfmt --to=iec-i --suffix=B $network_in) ↑$(numfmt --to=iec-i --suffix=B $network_out)"

