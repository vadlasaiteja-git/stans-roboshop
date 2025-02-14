systemd_setup(){
  print_head Copy SystemD service file
  cp $component.service /etc/systemd/system/$component.service &>>$log_file

  print_head Start Service
  systemctl daemon-reload &>>$log_file
  systemctl enable $component &>>$log_file
  systemctl restart $component &>>$log_file
}

aritfact_download(){
  print_head Add Application User
  useradd roboshop &>>$log_file

  print_head Remove existing application code
  rm -rf /app &>>$log_file

  print_head Create application directory
  mkdir /app &>>$log_file

  print_head Download Application Content
  curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip &>>$log_file
  cd /app

  print_head Extract Application Content
  unzip /tmp/$component.zip &>>$log_file
}

nodejs_app_setup(){
  print_head Disable NodeJS default version
  dnf module disable nodejs -y &>>$log_file

  print_head Enable NodeJS 20
  dnf module enable nodejs:20 -y &>>$log_file

  print_head Install NodeJS
  dnf install nodejs -y &>>$log_file


  aritfact_download
  cd /app

  print_head Install NodeJs Dependencies
  npm install &>>$log_file
  systemd_setup
}

maven_app_setup(){
  print_head Install Maven
  dnf install maven -y &>>$log_file


  aritfact_download
  cd /app

  print_head Install Maven Dependencies
  mvn clean package &>>$log_file
  mv target/$component-1.0.jar $component.jar &>>$log_file

  systemd_setup
}

python_app_setup(){
  print_head Install Python Packages
  dnf install python3 gcc python3-devel -y &>>$log_file


  aritfact_download
  cd /app

  print_head Install Python Dependencies
  pip3 install -r requirements.txt &>>$log_file
  systemd_setup
}

go_app_setup(){
  print_head Install GoLang Packages
  dnf install golang -y &>>$log_file


  aritfact_download
  cd /app
  print_head Intitialize Go Component
  go mod init $component &>>$log_file

  print_head Install GoLang Dependencies
  go get &>>$log_file
  go build &>>$log_file

  systemd_setup
}

print_head() {
  echo -e "\e[36m$*\e[0m"
  echo "#################################################" &>> $log_file
  echo -e "\e[36m$*\e[0m" &>> $log_file
  echo "#################################################" &>> $log_file
}

log_file=/tmp/roboshop.log
rm -f $log_file