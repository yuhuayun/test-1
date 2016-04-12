#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.0.35:80/python-redis-demo:${BUILD_NUMBER} .

docker push 192.168.0.35:80/python-redis-demo:${BUILD_NUMBER}
cd ${WORKSPACE}/test-build

sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml
chmod 777 ./rancher-compose

./rancher-compose --access-key B81DADD399EBAEE87209 --secret-key ic2x2zhYiYPTriCfLZmpConheJRbraguq47mtxLk -p python-redis-demo-build4 up --pull -d --confirm-upgrade --upgrade pyapp
