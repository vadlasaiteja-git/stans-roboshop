component=catalogue
source common.sh

print_head Copy MongoDB Repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo

nodejs_app_setup

print_head Install MongoDB
dnf install mongodb-mongosh -y

print_head Load Master Data
mongosh --host mongodb-dev.saitejasroboshop.store </app/db/master-data.js