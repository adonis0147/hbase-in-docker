#!/bin/bash

# update /etc/apt/sources.list
codename="$(grep DISTRIB_CODENAME /etc/lsb-release | awk -F = '{print $2}')"
echo "deb http://mirrors.aliyun.com/ubuntu/ ${codename} main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ ${codename} main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ ${codename}-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ ${codename}-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ ${codename}-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ ${codename}-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ ${codename}-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ ${codename}-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ ${codename}-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ ${codename}-backports main restricted universe multiverse" > /etc/apt/sources.list

# install prerequisites
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install --yes \
  sudo tzdata openssh-server vim openjdk-8-jdk openjdk-8-jre curl

apt-get autoclean && apt-get clean

# set timezone
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

# add a user
useradd hadoop -G sudo -m -d /home/hadoop -s /bin/bash -p $(openssl passwd -1 hadoop)

sudo -u hadoop echo '
#!/bin/bash

if [[ -f "${HOME}/.bashrc" ]]; then
  . "${HOME}/.bashrc"
fi
' > /home/hadoop/.bash_profile
