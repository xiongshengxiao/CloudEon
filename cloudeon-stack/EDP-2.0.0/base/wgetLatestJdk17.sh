#!/bin/bash

URL="https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz"
echo $URL
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" $URL $@