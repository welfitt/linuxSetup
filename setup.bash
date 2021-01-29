#!/usr/bin/bash
if [[ $(whoami) != "root" ]]
then
	echo "This needs to be run as root aborting"
	exit 1
fi
if ! groups welf | grep -q  wheel 
then
	echo "Adding welf to the wheel group and setting up sudo"
	usermod -a -G wheel welf
	sed -i 's/^%wheel/#%wheel/' /etc/sudoers
	sed -i 's/#%wheel\tALL=(ALL)\tNOPASSWD: ALL/%wheel\tALL=(ALL)\tNOPASSWD: ALL/' /etc/sudoers
fi

echo "Making SELinux permissive"

sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

echo "Turning on command line vi editing"
echo "set -o vi" >> /etc/bashrc
