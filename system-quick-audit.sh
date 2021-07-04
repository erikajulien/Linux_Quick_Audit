#!/bin/bash

var=`date +"%FORMAT_STRING"`
now=`date +"%m_%d_%Y"`

echo "Quick System Audit" >> quick-audit-results.txt
date >> quick-audit-results.txt
echo "" >> quick-audit-results.txt
echo "Machine Type Info:" >> quick-audit-results.txt
echo $MACHTYPE >> quick-audit-results.txt
echo -e "Uname info: $(uname -a) \n" >> quick-audit-results.txt
echo -e "IP Info: $(ip addr | grep inet | tail -2 | head -1) \n" >> quick-audit-results.txt
echo -e "Hostname: $(hostname -s) \n" >> quick-audit-results.txt
echo "DNS Servers: " >> quick-audit-results.txt
cat /etc/resolv.conf | grep nameservers >> quick-audit-results.txt
echo -e "\nMemory Info:" >> quick-audit-results.txt
free >> quick-audit-results.txt
echo -e "\nCPU Info:" >> quick-audit-results.txt
lscpu | grep CPU >> quick-audit-results.txt
echo -e "\nDisk Usage:" >> quick-audit-results.txt
df -h | head -2 >> quick-audit-results.txt
echo -e "\nWho is logged in: \n $(who -a) \n" >> quick-audit-results.txt
echo -e "\nSUID Files:" >> quick-audit-results.txt
find / -type f -perm /4000 >> quick-audit-results.txt
echo -e "\nTop 10 Processes" >> quick-audit-results.txt
ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >> quick-audit-results.txt
echo "Appending date to file results."
mv quick-audit-results.txt quick-audit-results-${now}.txt
echo "Quick audit complete! Created file quick-audit-results-TODAYSDATE.txt."


