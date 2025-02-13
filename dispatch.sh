component=dispatch
source common.sh
dnf install golang -y

useradd roboshop

cp dispatch.service /etc/systemd/system/dispatch.service

aritfact_download

cd /app
go mod init dispatch
go get
go build

systemd_setup