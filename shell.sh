#!/bin/bash

##################
#Author : Sathya
#Version : V1
#Breif : linux commands using script file
##################

set -x #debug mode writes the commands before executing
set -e #exits the script the 
set -o #pipeline failure 

df - h
nproc 
free
touch file
mkdir folder
ps -ef | grep amazon
ps -ef | grep amazion awk-F" " '{print $2}'
curl "https://github.com/iam-veeramalla/sandbox/blob/main/testlog" | grep Clustering
wget "https://github.com/iam-veeramalla/sandbox/blob/main/testlog" | grep Clustering
sudo find/ -name pam
#IF loop
a=20
b=40

if (( a > b )); then
    echo "a is greater"
else
    echo "b is greater"
fi

#FOOR Loop
for ((i=1; i<=5; i++))
do
    echo "number $i"
done
array=("lemon" "orange" "apple")
#FOOR Loop
for element in "${array[@]}"
do
    echo "element '$element'"
done

