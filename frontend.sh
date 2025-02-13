print_head(){
  echo -e "\e[32m$*\e[0m"
}

print_head Disable Default Nginx
dnf module disable nginx -y
print_head Enable Nginx 24
dnf module enable nginx:1.24 -y
print_head Install Nginx
dnf install nginx -y
print_head Copy Nginx Config file
cp nginx.conf /etc/nginx/nginx.conf
print_head Clean Old Content
rm -rf /usr/share/nginx/html/*
print_head Download App content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
cd /usr/share/nginx/html
print_head Extract app content
print_head unzip /tmp/frontend.zip
print_head Start Nginx Service
systemctl enable nginx
systemctl restart nginx