#!/bin/bash

# all copies go here into subdirectories by timestamp
TGT=~/autocopy

# Label of the device to be monitored
LBL=TOSHIBA

##
## end of Configuration
##

if [[ ! -e $TGT ]]; then
    echo "$TGT does not exist. Creating it."
    mkdir -p $TGT
fi

echo "Wating for device with label $LBL"
while true; do
    MOUNTED_TGT=$(findmnt LABEL=$LBL --noheadings --output TARGET)
    if [[ -n $MOUNTED_TGT ]]; then
	echo "USB-Stick with label $LBL found at $MOUNTED_TGT."
	TGTDIR=$TGT/$(date +'%Y-%m-%dT%H-%M-%S')
	echo "Creating $TGTDIR"
	mkdir -p $TGTDIR	
	echo "Moving files"
	mv -n -v $MOUNTED_TGT/* $TGTDIR
	echo "Unmounting device"
	umount $MOUNTED_TGT && echo "succeeded"
	echo '-----'
    fi
    sleep 2
done

