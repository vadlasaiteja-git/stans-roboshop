
component=cart
source common.sh

dnf module disable nodejs -y
dnf module enable nodejs:20 -y

dnf install nodejs -y

useradd roboshop

cp cart.service /etc/systemd/system/cart.service

aritfact_download

cd /app
npm install

systemd_setup