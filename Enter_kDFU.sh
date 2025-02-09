#!/bin/bash

## Ramdisk_Loader - Copyright 2019-2020, @Ralph0045

echo "**** SSH Ramdisk_Loader 2.0 ****"
echo made by @Ralph0045
echo Modified by LeoI07 for pwned DFU to kDFU conversion

if [ $# -lt 2 ]; then
echo "Usage:

-d      specify device by model

[example]

Enter_kDFU -d iPhone10,6
"
exit
fi

args=("$@")

for i in {0..2}
 do
    if [ "${args[i]}" = "-d" ]; then
        device=${args[i+1]}
    fi
done

## Check if 32/64 bit

type=$(echo ${device:0:6})

if [ "$type" = "iPhone" ]; then
    number=$(echo ${device:6} | awk -F, '{print $1}')
    if [ "$number" -gt "5" ]; then
        is_64="true"
    fi
else
    type=$(echo ${device:0:4})
    number=$(echo ${device:4} | awk -F, '{print $1}')
    if [ "$type" = "iPad" ]; then
        if [ "$number" -gt "3" ]; then
            is_64="true"
        fi
    else
        if [ "$type" = "iPod" ]; then
            if [ "$number" -gt "5" ]; then
                is_64="true"
            fi
        fi
    fi
fi

if [ -e "SSH-Ramdisk-"$device"" ]; then
echo "SSH-Ramdisk-"$device" exists"
else
echo "SSH-Ramdisk-"$device" does not exist"
exit
fi

cd SSH-Ramdisk-$device

if [ "$is_64" = "true" ]; then
    echo 64-bit devices are not supported yet.
    exit
    ## Existing code kept here for future 64-bit device support.
    echo Sending iBSS
    sleep 2s
    irecovery -f iBSS.img4
    echo Sending iBEC
    irecovery -f iBEC.img4
    sleep 2s
    irecovery -f iBEC.img4
    irecovery -c go
    echo Sending ramdisk
    irecovery -f ramdisk.img4
    irecovery -c ramdisk
    echo Sending applelogo
    irecovery -f applelogo.img4
    irecovery -c "setpicture 5"
    echo Sending devicetree
    irecovery -f devicetree.img4
    irecovery -c devicetree
    
    if [ -e "trustcache" ]; then
    echo Sending trustcache
    irecovery -f trustcache
    irecovery -c firmware
    fi
    echo Sending Kernelcache
    irecovery -f kernelcache.img4
    irecovery -c bootx
else
    echo Sending iBSS...
    irecovery -f iBSS
    echo Sending iBEC...
    irecovery -f iBEC
    irecovery -r
    echo Sending ramdisk...
    irecovery -f ramdisk.dmg
    irecovery -c ramdisk
    echo Sending device tree...
    irecovery -f devicetree
    irecovery -c devicetree
    echo Sending kernel cache...
    irecovery -f kernelcache
    echo Booting ramdisk...
    irecovery -c bootx
fi

iproxy 2222 22 &

echo Waiting for ramdisk to boot...
## On an iPad2,5 you must wait for more than ~3.285 seconds.
sleep 4
until ssh -p 2222 root@127.0.0.1 "kloader iBSS"; do
    echo Failed to SSH into ramdisk. Trying again in 1 second...
    sleep 1
done

echo Done
cd ..
exit