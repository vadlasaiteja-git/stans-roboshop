component=catalogue
source common.sh
dnf module disable nodejs -y
dnf module enable nodejs:20 -y

dnf install nodejs -y

cp catalogue.service /etc/systemd/system/catalogue.service
cp mongo.repo /etc/yum.repos.d/mongo.repo

useradd roboshop

aritfact_download

cd /app

npm install

systemd_setup

dnf install mongodb-mongosh -y

mongosh --host mongodb-dev.saitejasroboshop.store </app/db/master-data.js