systemd_setup(){
  systemctl daemon-reload
  systemctl enable $component
  systemctl restart $component
}

aritfact_download(){
  rm -rf /app
  mkdir /app
  curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip
  cd /app
  unzip /tmp/$component.zip
}