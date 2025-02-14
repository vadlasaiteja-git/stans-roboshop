source common.sh

print_head  Disable redis default version
dnf module disable redis -y

print_head Enable Redis 7
dnf module enable redis:7 -y

print_head Install Redis
dnf install redis -y

print_head Update redis config file
sed -i -e 's|127.0.0.1|0.0.0.0|' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf

print_head Start Redis Service
systemctl enable redis
systemctl start redis

