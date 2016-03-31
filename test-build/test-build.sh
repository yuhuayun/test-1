#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.0.190:80/python-redis-demo:${BUILD_NUMBER} .

docker push 192.168.0.190:80/python-redis-demo:${BUILD_NUMBER}
cd ${WORKSPACE}/test-build

sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml
chmod 777 ./rancher-compose

./rancher-compose --access-key 835FE7ADA01ED73A9BDE --secret-key vzQmg3z6kKAsYg9sYeNDoWTsh5Vht1i9TQewYyxz -p python-redis-demo-build${BUILD_NUMBER} up -d

