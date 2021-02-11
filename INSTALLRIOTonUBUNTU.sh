#!/bin/bash
# Installs all you need to start with RIOT-os on Ubuntu
# ubuntu packages, arm compiler and riot-os
# for this reason it will use sudo - to install packages
# it can also download RIOT (into current dir so you may have to move it up to ~/RIOT for an easy life)
# and the ARM compiler will be put in a central location (so you need to set PATH)
# Kirk Martinez June 2020
# ubuntu 20 only has python3 - affects python3-serial and python3-pip
# needs sudo to install packages and config files

sudo apt install python3-serial git build-essential python3-pip
sudo apt install pkg-config autoconf automake libtool libusb-dev libusb-1.0-0-dev libhidapi-dev libftdi-dev libudev-dev

pip3 install pyserial

if [ -e RIOT ] ; then
	echo "you already have a RIOT dir here"
else
	echo "getting RIOT-OS from github"
	git clone git://github.com/RIOT-OS/RIOT.git
fi

grep dialout < /etc/group | grep $USER
if [[ $? == 0 ]]; then
	echo "already in dialout group "
else
	echo "adding user to dialout group for access to /dev/tty.."
	sudo usermod --append --groups dialout $USER
	echo "YOU WILL HAVE TO LOG OUT AND BACK IN AGAIN afterwards"
fi
read -p "Do you want to install OpenOCD (eg for SAMR)? [yn]" yn
if [ $yn == "y" ]; then
	echo "installing OpenOCD" 
	git clone git://git.code.sf.net/p/openocd/code openocd 
	cd openocd 
	./bootstrap 
	./configure 
	make 
	sudo make install
	echo "checking for udev rule"
	if [ ! -f /etc/udev/rules.d/99-usb.rules ] ; then
		echo "adding udev rule file /etc/udev/rules.d/99-usb.rules"
		echo "KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0664", GROUP="plugdev"" | sudo tee --append /etc/udev/rules.d/99-usb.rules

		sudo service udev restart
	fi
fi

read -p "Do you need ARM compiler? [yn]" yn
if [ $yn == "y" ]; then
	echo "installing ARM compiler" 
	echo "using 2019 compiler from ARM site" 
	armtarball="https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2?revision=108bd959-44bd-4619-9c19-26187abf5225&la=en&hash=E788CE92E5DFD64B2A8C246BBA91A249CB8E2D2D"
	wget -q -O /tmp/armgcc.tar.bz2 $armtarball  
	echo "installing in your opt dir"
	mkdir -p $HOME/opt 
	cd $HOME/opt 
	tar xf /tmp/armgcc.tar.bz2 
	rm /tmp/armgcc.tar.bz2 
	echo "****remember to add ~/opt/gcc-arm-etcetc/bin in your PATH****" 
	echo "eg: PATH=\$PATH:~/opt/gcc-arm-none-eabi-9-2019-q4-major/bin"
fi

