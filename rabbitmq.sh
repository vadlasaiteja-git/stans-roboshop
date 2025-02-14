source common.sh

print_head Copy RabbitmQ repo file
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo

print_head Install RabbitmQ Server
dnf install rabbitmq-server -y

print_head Start RabbitMQ Service
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

print_head Add application user
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"