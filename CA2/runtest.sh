#!/bin/bash
echo "C0	N	Idle" > results.dat
for i in {1..50}
do
./loadtest $i &
idle=`mpstat 1 1 -o JSON | jq ' .sysstat.hosts[0].statistics[0]."cpu-load"[0].idle'`

cnt=`cat synthetic.dat | wc -l`

echo -e "$cnt\t $i \t $idle" >> results.dat
pkill loadtest
done
