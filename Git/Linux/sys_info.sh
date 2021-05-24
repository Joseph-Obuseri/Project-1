#!/bin/bash

# A title
echo "System Information Script"

# Today's date
date
echo " "

# The machine's type
echo "Machine Type Info"
echo $MACHTYPE

# The uname info for the machine
echo -e "Uname info: $(uname -a) \n"

# The machine's IP address
echo -e "IP info: $(IP addr | head -9 | tail -1) \n"

# The Hostname
echo "Hostname: $(hostname -s)"


# Bonuses:
echo Bonuses

# The DNS info
echo "DNS Servers:"
cat /etc/resolv.conf

# The Memory info
echo "Memory Info:"
free

# The CPU info
echo -e "\nCPU Info:"
lscpu | grep CPU

# The Disk usage
echo -e "\nDisk Usage:"
df -H | head -2

# The currently logged on users
echo -e "\nWho is logged in: \n $(who -a) \n"

