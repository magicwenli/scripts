#/bin/bash
# set -x
sed -i 's/isula cp/docker cp/g' $(grep 'isula cp' -rl ~/mini_internet_project/platform)
sed -i 's/isula exec/docker exec/g' $(grep 'isula exec' -rl ~/mini_internet_project/platform)
sed -i 's/isula ps/docker ps/g' $(grep 'isula ps' -rl ~/mini_internet_project/platform)
sed -i 's/isula inspect/docker inspect/g' $(grep 'isula inspect' -rl ~/mini_internet_project/platform)
sed -i 's/isula run/docker run/g' $(grep 'isula run' -rl ~/mini_internet_project/platform)
sed -i 's/isula kill/docker kill/g' $(grep 'isula kill' -rl ~/mini_internet_project/platform)
sed -i 's/isula start/docker start/g' $(grep 'isula start' -rl ~/mini_internet_project/platform)
sed -i 's/isula restart/docker restart/g' $(grep 'isula restart' -rl ~/mini_internet_project/platform)
sed -i 's/isula login/docker login/g' $(grep 'isula login' -rl ~/mini_internet_project/platform)
sed -i 's/isula pull/docker pull/g' $(grep 'isula pull' -rl ~/mini_internet_project/platform)
sed -i 's/isula images/docker images/g' $(grep 'isula images' -rl ~/mini_internet_project/platform)

sed -i 's/^.*status=exited.*$/docker system prune -f/g' $(grep 'status=exited' -rl ~/mini_internet_project/platform)

sed -i 's/isula-build/docker build/g' $(grep 'isula-build' -rl ~/mini_internet_project/platform)