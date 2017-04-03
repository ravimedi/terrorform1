#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

Error() {
	echo -e "$R$1$N"
}


OS=$(facter |grep 'operatingsystem '|awk '{print $NF}')
ARCH=$(facter |grep 'hardwaremodel' |awk '{print $NF}')

if [ "$OS" != 'CentOS' -o "$ARCH" != 'x86_64' ]; then 
	Error "This script is meant to run on CentOS 7 - x86_64 Operating System"
	exit 5
fi

if [ $UID -ne 0 ]; then 
	Error "This script should be run by root user"
	exit 6
fi

#### Installing Chef Client
DOWNLOAD_URL=$(curl -L https://downloads.chef.io/chef 2>/dev/null|tr "<" "\n" |grep Download$ |grep rpm  |grep el7.x86_64 | sed -e 's|&#x2F;|/|g' |awk -F '"' '{print $(NF-1)}')
yum install $DOWNLOAD_URL -y &>/dev/null

##### CookBook Location #####
URL=http://github.com/versionit
REPO="$URL/demo"
BRANCH=master
################

##### Downloading Cook Books
yum install git -y &>/dev/null
cd /opt 
[ -e demo ] && rm -rf demo
mkdir demo
cd demo
git init &>/dev/null 
git pull $REPO $BRANCH &>/dev/null 

## Checking ENV
if [ ! -f /ENV ]; then 
	Error "Server creation is not standard.. Cannot proceed"
	exit 7
fi
ENV=$(cat /ENV)
cd /opt/demo/$ENV

##### Setting chef-solo requirement

cd /opt/demo/$ENV
mkdir .chef
COOKBOOK_PATH="/opt/demo/$ENV/cookbooks"
echo "cookbook_path [ \"$COOKBOOK_PATH\" ]" > .chef/knife.rb
echo "cookbook_path [ \"$COOKBOOK_PATH\" ]" > $COOKBOOK_PATH/solo.rb


#### Applying CookBooks
cd $COOKBOOK_PATH
chef-solo -c solo.rb -o recipe[tomcat::default]

