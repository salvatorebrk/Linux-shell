#!/bin/bash
#Author Salvatore Bruccoleri 10/25/17
BAUD=38400
MY_IP=192.168.220.10
U_IP=192.168.220.1
#Include module SLIP/CSLIP when you compile Kernel
echo "Start Slip on Toradex Colibri i.MX6DL"
insmod /lib/modules/3.14.52-v2.6.1b1+g3894f6d/kernel/drivers/net/slip/slhc.ko
if [[ $? != 0 ]]                        
then
    echo "Impossible run slhc.ko"
    exit 1
fi
insmod /lib/modules/3.14.52-v2.6.1b1+g3894f6d/kernel/drivers/net/slip/slip.ko
if [[ $? != 0 ]]                        
then
    echo "Impossible run slip.ko"
    exit 1
fi
echo "Kernel MODULE UP"
slattach -L -p slip -s $BAUD /dev/ttymxc1 -d &
ifconfig sl0 $MY_IP netmask 255.255.255.0 pointopoint $U_IP up
ifconfig sl0
echo "End SCRIPT"
