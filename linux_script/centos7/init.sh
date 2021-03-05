#!bin/bash

yum -y install vim wget git lrzsz net-tools tree nmap gcc gcc-c++ fish tmux

# cp .bashrc
destDir="${HOME}/.config/fish/"
if [ ! -d $destDir ]; then
  mkdir -p $destDir
fi

sudo cp ./conf/.bashrc ~/
sudo cp ./conf/config.fish $destDir
sudo cp ./conf/.tmux.conf ~/
tmux source-file ~/.tmux.conf


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
echo "Git config have been set."