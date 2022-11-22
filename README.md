# Pwned DFU to kDFU converter for 32/64-bit devices

## What's the point?
Some tools are designed to work with kDFU mode and do not work properly with pwned DFU mode. This tool will allow you to enter kDFU mode without needing to jailbreak your device.

## There's no warranty provided!

## How to use it  </br>
Getting the requirements: </br>
```
bash Requirements.sh
```
Making the ramdisk: </br>
```
bash Ramdisk_Maker.sh -d <device> -i <version>
```
Getting a dropbear_rsa_host_key (only needed on 64-bit devices, requires a jailbreak) : </br>
```
bash get_dropbear_key.sh
```
Booting it : </br>

Put the device in pwned DFU mode and:
```
bash Enter_kDFU.sh -d <device>
```
Note: You need libirecovery

## Does it work?
Not on any devices I've tested it on. The ramdisk boots from kDFU mode on an iPad2,5, but it does not re-enter kDFU.

# Credits/Thanks to
- @Ralph0045 for his SSH ramdisk maker and loader </br>
- @iH8sn0w for iBoot32Patcher </br>
- msftguy for ssh-rd </br>
- @daytonhasty for Odysseus and kairos </br>
- @mcg29_ for compare script </br>
- @Jakeashacks for rootlessjb </br>
- @tihmstar for partialzipbrowser </br>
- @xerub for img4lib </br>
- @tihmstar for libfragmentzip, partialZipBrowser and tsschecker </br>
- @axi0mX for his ios-kexec-utils [fork](https://github.com/axi0mX/ios-kexec-utils)
- @LukeZGD1 for [iOS-OTA-Downgrader](https://github.com/LukeZGD/iOS-OTA-Downgrader), which some code is borrowed from
