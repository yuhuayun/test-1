#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.5.17:5002/admin/python-with-flask-redis:${BUILD_NUMBER} .

docker push 192.168.5.17:5002/admin/python-with-flask-redis:${BUILD_NUMBER}
cd ${WORKSPACE}/test-build

sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml
chmod 777 ./rancher-compose

./rancher-compose --access-key 109A9CB5565FA0990DE0 --secret-key 2myabxx5kHuEg7eQk9gcSnKeudcWepMxJJfRDpZv -p python-redis-demo-build4 up --pull -d --confirm-upgrade --upgrade pyapp
