component=shipping
source common.sh

maven_app_setup
print_head Install MySQL Client
dnf install mysql -y

print_head Load Schema
mysql -h mysql-dev.saitejasroboshop.store -uroot -pRoboShop@1 < /app/db/schema.sql

print_head Load User creation
mysql -h mysql-dev.saitejasroboshop.store -uroot -pRoboShop@1 < /app/db/app-user.sql

print_head Load Master Data
mysql -h mysql-dev.saitejasroboshop.store -uroot -pRoboShop@1 < /app/db/master-data.sql

