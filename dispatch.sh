component=dispatch
source common.sh
dnf install golang -y

useradd roboshop

cp dispatch.service /etc/systemd/system/dispatch.service

rm -rf /app
mkdir /app

curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app
unzip /tmp/dispatch.zip

cd /app
go mod init dispatch
go get
go build

systemd_setup