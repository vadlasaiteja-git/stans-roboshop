source common.sh

print_head Install MySQL Server
dnf install mysql-server -y &>>$log_file
exit_status_print $?

print_head Start MySQL Service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
exit_status_print $?
print_head Setup Root Password
mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file
exit_status_print $?