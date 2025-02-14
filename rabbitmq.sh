source common.sh

print_head Copy RabbitmQ repo file
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$log_file
exit_status_print $?

print_head Install RabbitmQ Server
dnf install rabbitmq-server -y &>>$log_file
exit_status_print $?

print_head Start RabbitMQ Service
systemctl enable rabbitmq-server &>>$log_file
systemctl start rabbitmq-server &>>$log_file
exit_status_print $?

print_head Add application user
rabbitmqctl add_user roboshop roboshop123 &>>$log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
exit_status_print $?