#!/bin/bash
if [ $UID -ne 0 ]; then
  echo "Please run this script as root/sudo."
exit
fi

#Variables
var=`date +"%FORMAT_STRING"`
now=`date +"%m_%d_%Y"`
exes=$(sudo find /home -type f -perm 777 2>/dev/null)
output=quick-audit-results

#Lists
files=(
  '/etc/passwd'
  '/etc/shadow'
)

#################SCRIPT START########################
echo "Quick System Audit" >> $output.txt
echo $date >> $output.txt
echo "" >> $output.txt

echo "Machine Type Info:" >> $output.txt
echo $MACHTYPE >> $output.txt
echo "" >> $output.txt

echo -e "Uname info: $(uname -a) \n" >> $output.txt

echo -e "Hostname: $(hostname -s) \n" >> $output.txt

echo -e "IP Info: $(ip addr | grep inet | tail -2 | head -1) \n" >> $output.txt

echo "DNS Servers:" >> $output.txt
cat /etc/resolv.conf | grep nameservers >> $output.txt

echo -e "\nMemory Info:" >> $output.txt
free >> $output.txt

echo -e "\nCPU Info:" >> $output.txt
lscpu | grep CPU >> $output.txt

echo -e "\nDisk Usage:" >> $output.txt
df -h | head -2 >> $output.txt

echo -e "\nWho is logged in:" >> $output.txt
echo -e "$(who -a) \n" >> $output.txt

echo -e "\nSUID Files:" >> $output.txt
for exe in $exes; do
 echo "$exes" >> $output.txt
done

echo -e "\nTop 10 Processes" >> $output.txt
ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> $output.txt

echo -e "\nSensitive /etc file permissions:" >> $output.txt
for file in ${files[@]}; do
  ls -l $file >> $output.txt
done

echo -e "\nEND REPORT" >> $output.txt

echo  "Appending date to file results."
mv $output.txt $output-${now}.txt

echo "Quick Audit Complete!"
