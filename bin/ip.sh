#!/bin/sh
wget -q -O - checkip.dyndns.org | sed -e 's/[^[:digit:]\|.]//g'
