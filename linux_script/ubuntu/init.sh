#!bin/bash

# some code from https://github.com/Gstalker/Auto-init-your-ubuntu18/blob/master/init_your_ubuntu.sh

function python3_check(){
  if python3 -c "import $1" >/dev/null 2>&1
  then
      echo "true"
  else
      echo "false"
  fi
}

function command_check(){
  if command -v $1 > /dev/null;then
    echo "true"
  else
    echo "false"
  fi
}

# cp .bashrc
sudo cp ./conf/.bashrc ~/

# get the system version
version=$(lsb_release -rs)
code=$(lsb_release -cs)
echo "Current Ubuntu version is ${version}. code = ${code}."


# bak the original list
sudo cp -ra /etc/apt/sources.list /etc/apt/sources.list.bak

echo "deb http://mirrors.aliyun.com/ubuntu/ ${code} main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ ${code}-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ ${code}-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ ${code}-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ ${code}-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ ${code} main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ ${code}-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ ${code}-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ ${code}-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ ${code}-backports main restricted universe multiverse" | sudo tee /etc/apt/sources.list

sudo apt-get update
# sudo apt-get -y upgrade 

# install python3-pip
sudo apt-get -y install python3-pip
sudo -H python3 -m pip install -U pip -i https://pypi.tuna.tsinghua.edu.cn/simple
sudo -H python3 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# check python3-pip
success_python3_pip=$(python3_check pip)

# install git
sudo apt -y install git
success_git=$(command_check git)

# install fish
sudo apt -y install fish
success_fish=$(command_check fish)

destDir="${HOME}/.config/fish/"
if [ ! -d $destDir ]; then
  mkdir -p $destDir
fi
sudo cp ./conf/config.fish $destDir

# install tmux
sudo apt -y install tmux
cp ./conf/.tmux.conf ~/
tmux source-file ~/.tmux.conf


# curl
sudo apt -y install curl
success_curl=$(command_check curl)

# net-tools
sudo apt -y install net-tools
success_net_tools=$(command_check ifconfig)

# docker
read -r -p "Install Docker? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
      curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
sudo cat > /etc/docker/daemon.json << EOF
{
    "registry-mirrors" : [
    "https://registry.docker-cn.com",
    "https://docker.mirrors.ustc.edu.cn",
    "http://hub-mirror.c.163.com",
    "https://cr.console.aliyun.com/"
  ]
}
EOF

sudo usermod -aG docker "${USER}"
sudo systemctl restart docker
sudo chmod a+rw /var/run/docker.sock
    ;;

    [nN][oO]|[nN])
    echo "Escape installing Docker"	
    ;;

    *)
    echo "Invalid input..."
    ;;
esac


# run v2raya

read -r -p "Install V2rayA? [Y/n] " input

case $input in
    [yY][eE][sS]|[yY])
docker run -d \
 --restart=always \
 --privileged \
 --network=host \
 --name v2raya \
 -v /etc/resolv.conf:/etc/resolv.conf \
 -v /etc/v2raya:/etc/v2raya \
 mzz2017/v2raya
    echo "With V2RayA service running, visit the port 2017 to enjoy it (such as http://localhost:2017)."
    ;;

    [nN][oO]|[nN])
    echo "Escape installing Docker"	       	
    ;;

    *)
    echo "Invalid input..."
    ;;
esac

# install vim
sudo apt -y install vim
# https://github.com/amix/vimrc basic version
# git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
# sh ~/.vim_runtime/install_basic_vimrc.sh

# setup git 
echo -n "enter your git user.name: "
read name
echo -n "enter your git user.email: "
read email

git config --global user.name "${name}"
git config --global user.email "${email}"

source ~/.bashrc
echo "Open localhost:2017 to setup proxy"