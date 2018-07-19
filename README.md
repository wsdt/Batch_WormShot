# Batch_WormShot [![GitHub license](https://img.shields.io/github/license/wsdt/Batch_WormShot.svg)](https://github.com/wsdt/Batch_WormShot/blob/master/LICENSE) [![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/) [![Maintenance](https://img.shields.io/badge/Maintained%3F-no-red.svg)](https://bitbucket.org/lbesson/ansi-colors)

Control any Windows device remotely (if WormShot is installed there). 

## Install/Infect a pc
To do this please use one of the Install Tools: https://github.com/wsdt/Batch_WormShot/tree/master/WormShot/SYS/INSTALL_Tools

### Installing manually
To install WormShot manually go to the folder "C:\users\%username%\" on your victim's device and paste there the "WormShot"-folder of this repository. Then configure the victim's pc so, that your attacking pc can access the folder via network. After that the control panel of ["Smart Speed" (=Batch Helper)](https://github.com/wsdt/Batch_Helper) should find the WormShot installation over your network. 

Of course Wormshot needs to run in background, but fortunately I included several methods to install WormShot which do that. 

## Improvements / Other variants
I started a few years ago to make WormShot portable. So, you could place the WormShot folder on a shared drive (e.g. of an enterprise) and change an arbitrary file/folder to a linked file which hiddenly starts WormShot and opens the users' desired folder/file afterwards. 

This would remove the network configuration dependencies, the admin rights requirements and would allow you to control multiple devices at once. 

## Contribution [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
As I do not maintain this application and scripted this when I was appr. 13-15 years old, some things might not work anymore. Though there shouldn't be anything hardcoded, since I had the permission in school to test it by spreading it via a trojan. 
Nevertheless pull-requests and issues are welcome. 

## No Warranty
As I made many years ago at school age, I just wanted to learn the language. This software was never used (without explicitely permission of all participants) outside of my own private network at home. So, I don't take any warranty in using this software and want to encourage you to use this software **only** for education purposes. Please be responsible and don't do sth. you will regret later. 
