source common.sh

print_head Copy MongoDB repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo

print_head Install MongoDB
dnf install mongodb-org -y

print_head Update MongoDb config file
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

print_head Start MongoDB Service
systemctl enable mongod
systemctl restart mongod