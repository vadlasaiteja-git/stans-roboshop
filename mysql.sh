source common.sh

print_head Install MySQL Server
dnf install mysql-server -y

print_head Start MySQL Service
systemctl enable mysqld
systemctl start mysqld

print_head Setup Root Password
mysql_secure_installation --set-root-pass RoboShop@1