#/bin/bash -x
# set -x

# docker cp exec ps inspect run kill start restart login pull images
# ---->
# isula CMD

sed -i 's/docker cp/isula cp/g' $(grep 'docker cp' -rl ~/mini_internet_project/platform)
sed -i 's/docker exec/isula exec/g' $(grep 'docker exec' -rl ~/mini_internet_project/platform)
sed -i 's/docker ps/isula ps/g' $(grep 'docker ps' -rl ~/mini_internet_project/platform)
sed -i 's/docker inspect/isula inspect/g' $(grep 'docker inspect' -rl ~/mini_internet_project/platform)
sed -i 's/docker run/isula run/g' $(grep 'docker run' -rl ~/mini_internet_project/platform)
sed -i 's/docker kill/isula kill/g' $(grep 'docker kill' -rl ~/mini_internet_project/platform)
sed -i 's/docker start/isula start/g' $(grep 'docker start' -rl ~/mini_internet_project/platform)
sed -i 's/docker restart/isula restart/g' $(grep 'docker restart' -rl ~/mini_internet_project/platform)
sed -i 's/docker login/isula login/g' $(grep 'docker login' -rl ~/mini_internet_project/platform)
sed -i 's/docker pull/isula pull/g' $(grep 'docker pull' -rl ~/mini_internet_project/platform)
sed -i 's/docker images/isula images/g' $(grep 'docker images' -rl ~/mini_internet_project/platform)

# docker system prune -f
# ---->
# isula volume rm $(isula volume ls -qf dangling=true)
# isula rm -v $(isula ps -aq -f status=exited)
# isula rm -v $(isula ps -aq -f status=dead)

sed -i 's/^.*prune.*$/isula rm -v $(isula ps -aq -f status=exited)/g' $(grep 'docker system prune' -rl ~/mini_internet_project/platform)

# docker build
# ---->
# isula-build 
sed -i 's/docker build/isula-build/g' $(grep 'docker build' -rl ~/mini_internet_project/platform)

sed -i 's/cpus=2//g' $(grep 'cpus=2' -rl ~/mini_internet_project/platform)