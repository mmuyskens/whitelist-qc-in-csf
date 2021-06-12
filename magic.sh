#!/bin/bash

echo "Downloading list..."
wget -O ips.txt 'https://www.quic.cloud/ips?ln'

echo "Comparing to last run state..."

if [ -f "lastrun.txt" ]; then
    fgrep -vf lastrun.txt ips.txt > dif.txt
else
    echo "No last run state detected..."
    cp ips.txt dif.txt
fi

echo "Starting list parsing..."
cat dif.txt | while read LINE
do
    csf -a $LINE
done

echo "Saving lastrun state..."
mv -f ips.txt lastrun.txt

echo "Cleaning up..."
rm dif.txt

echo "Done!"
