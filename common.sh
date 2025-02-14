systemd_setup(){
  print_head Copy SystemD service file
  cp $component.service /etc/systemd/system/$component.service

  print_head Start Service
  systemctl daemon-reload
  systemctl enable $component
  systemctl restart $component
}

aritfact_download(){
  print_head Add Application User
  useradd roboshop

  print_head Remove existing application code
  rm -rf /app

  print_head Create application directory
  mkdir /app

  print_head Download Application Content
  curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip
  cd /app

  print_head Extract Application Content
  unzip /tmp/$component.zip
}

nodejs_app_setup(){
  print_head Disable NodeJS default version
  dnf module disable nodejs -y

  print_head Enable NodeJS 20
  dnf module enable nodejs:20 -y

  print_head Install NodeJS
  dnf install nodejs -y


  aritfact_download
  cd /app

  print_head Install NodeJs Dependencies
  npm install
  systemd_setup
}

maven_app_setup(){
  print_head Install Maven
  dnf install maven -y


  aritfact_download
  cd /app

  print_head Install Maven Dependencies
  mvn clean package
  mv target/$component-1.0.jar $component.jar

  systemd_setup
}

python_app_setup(){
  print_head Install Python Packages
  dnf install python3 gcc python3-devel -y


  aritfact_download
  cd /app

  print_head Install Python Dependencies
  pip3 install -r requirements.txt
  systemd_setup
}

go_app_setup(){
  print_head Install GoLang Packages
  dnf install golang -y


  aritfact_download
  cd /app
  print_head Intitialize Go Component
  go mod init $component

  print_head Install GoLang Dependencies
  go get
  go build

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