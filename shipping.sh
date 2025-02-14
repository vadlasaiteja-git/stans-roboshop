component=shipping
source common.sh

maven_app_setup
print_head Install MySQL Client
dnf install mysql -y &>>$log_file
exit_status_print $?

for file in schema app-user master-data;do
  print_head Load $file
  mysql -h mysql-dev.saitejasroboshop.store -uroot -pRoboShop@1 < /app/db/$file.sql &>>$log_file
  exit_status_print $?
done

#print_head Load User creation
#mysql -h mysql-dev.saitejasroboshop.store -uroot -pRoboShop@1 < /app/db/app-user.sql &>>$log_file
#exit_status_print $?

#print_head Load Master Data
#mysql -h mysql-dev.saitejasroboshop.store -uroot -pRoboShop@1 < /app/db/master-data.sql &>>$log_file
#exit_status_print $?
