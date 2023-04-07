#!/bin/bash
# Author : Raymond Val raymond.val@gmailcom
#
# Purpose: Add BGInfo like information on Linux Desktop
# File name: bginfo.sh
 
SCHOME=$HOME/bin/bginfo
BGFILE=$SCHOME/sys.info
BG=$SCHOME/bg.png ### This is a generated image with sys information
WALL=$SCHOME/wall.png ### This is your original background image
NEWWALL=$SCHOME/newwall.png ### This is the new background image that you will use
 
> $BGFILE
 
   A_UPTIME="                      Uptime : "
 A_HOSTNAME="                   Host Name : "
 A_USERNAME="                   User Name : "
   A_NUMCPU="                  Num of CPU : "
 A_CPUMODEL="                   CPU Model : "
 A_MEMTOTAL="                Total Memory : "
A_OSVERSION="                  OS Version : "
A_IPADDRESS="                  IP Address : "
A_DNSSERVER="                  DNS Server : "
  A_GATEWAY="                     Gateway : "
 A_FREEDISK="             Disk Free Space : "
 A_SOFTWAR1="                                 "
 A_SOFTWAR2="                                 "
 A_SOFTWAR3="                                 "
 
B_UPTIME=`procinfo | grep uptime | awk '{print $2}'`
B_HOSTNAME=`hostname`
B_USERNAME=`whoami`
B_NUMCPU=`cat /proc/cpuinfo | grep processor | wc -l`
B_CPUMODEL=`cat /proc/cpuinfo | grep "model name" | awk -F":" '{print $2}' | head -1 | sed -e 's/^ *//'`
B_MEMTOTAL=`cat /proc/meminfo | grep MemTotal | sed -e 's/^ *//' | awk -F":" '{print $2}'`
B_OSVERSION=`uname -srm`
B_IPADDRESS=`/sbin/ifconfig | grep "inet" | grep -v 127.0.0.1 | grep -v ":" |awk '{print $2}'`
B_DNSSERVER=`grep ^nameserver /etc/resolv.conf | awk '{print $2}'` 
B_GATEWAY=`netstat -rn | grep UG | awk '{print $2}'` 
B_FREEDISK=`df -k | grep ^/dev | awk '{print $1" "$4" KB Available"}'`
 
echo "$A_UPTIME" $B_UPTIME >> $BGFILE
echo "$A_HOSTNAME" $B_HOSTNAME >> $BGFILE
echo "$A_USERNAME" $B_USERNAME >> $BGFILE
echo "$A_OSVERSION" $B_OSVERSION >> $BGFILE
echo "$A_IPADDRESS" $B_IPADDRESS >> $BGFILE
echo "$A_NUMCPU" $B_NUMCPU >> $BGFILE
echo "$A_DNSSERVER" $B_DNSSERVER >> $BGFILE
echo "$A_CPUMODEL" $B_CPUMODEL >> $BGFILE
echo "$A_MEMTOTAL" $B_MEMTOTAL >> $BGFILE
echo "$A_GATEWAY" $B_GATEWAY >> $BGFILE
echo " " >> $BGFILE
#echo "$A_SOFTWARE" >> $BGFILE
#echo "$A_SOFTWAR1" >> $BGFILE
#echo "$A_SOFTWAR2" >> $BGFILE
#echo "$A_SOFTWAR3" >> $BGFILE
 
### The following ImageMagick utility generates an image with the 
### transparent background from the file $BGFILE
 
cat $BGFILE | \
convert -font Liberation-Mono -pointsize 24 \
        -background none \
        -fill aqua \
        label:@- $BG 
 
### This utility combines two images and creates a new image

composite -gravity southeast $BG $WALL $NEWWALL

