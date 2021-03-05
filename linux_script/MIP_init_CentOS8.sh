set -o errexit
set -o pipefail

echo “安装 iSulad jq go”
yum update -y

cat << EOF > /etc/yum.repos.d/openEuler.repo
[openEuler]
baseurl=https://repo.openeuler.org/openEuler-20.03-LTS/OS/\$basearch
enabled=1
EOF

rpm --import https://repo.openeuler.org/openEuler-20.03-LTS/OS/x86_64/RPM-GPG-KEY-openEuler
yum install -y  iSulad jq
rm /etc/yum.repos.d/openEuler.repo


echo “修改CNI”

cd
rm -rf CNI
mkdir CNI
cd CNI
mkdir -p /etc/cni/net.d
cat >> /etc/cni/net.d/10-mynet.json << EOF
{
  "cniVersion": "0.3.0",
  "name": "default",
  "type": "bridge",
  "bridge": "cni0",
  "ipam": {
    "type": "host-local",
    "subnet": "10.1.0.0/16",
    "gateway": "10.1.0.1"
  },
  "dns": {
    "nameservers": [ "10.1.0.1" ]
  }
}
EOF


echo “containernetworking”
cd
git clone https://gitee.com/motoko/plugins.git
cd plugins/
./build_linux.sh
mkdir -p /opt/cni/bin
cp ./bin/* /opt/cni/bin/

cd
rm -rf iSula
mkdir iSula && cd iSula
cp /etc/isulad/daemon.json /etc/isulad/daemon.json.bak
cp ~/linux_script/openEuler/daemon.json /etc/isulad/daemon.json

# 添加环境变量
cat >> ~/.bashrc << EOF
export CNI_PATH=/opt/cni/bin
export PATH=$PATH:$CNI_PATH
export NETCONFPATH=/etc/cni/net.d
EOF


# 重启 isulad
systemctl restart isulad


# 安装 isula-build
sodu yum install -y make git bzip2 golang

cd ~/linux_script/centos8
tar -xjvf isula-build.tar.gz
cd isula-build
make install

# # 安装isula-build编译环境
# sudo yum install -y  make btrfs-progs-devel device-mapper-devel glib2-devel gpgme-devel libassuan-devel libseccomp-devel git bzip2 systemd-devel golang

# cd
# git clone https://gitee.com/openeuler/isula-build.git

# # 编译
# cd isula-build
# sudo make
# sudo make install

# sudo install -p -m 640 ./isula-build.service /etc/systemd/system/isula-build.service
# sudo systemctl enable isula-build
# sudo systemctl start isula-build

# sudo yum install -y docker


# clone mini_internet_project
sudo yum install -y openvpn
# curr_path=$(dirname $0)
cd 
git clone https://gitee.com/motoko/mini_internet_project.git
cd mini_internet_project

time && echo "Done!"