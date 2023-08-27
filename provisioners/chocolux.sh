yum install nginx -y

systemctl enable nginx
systemctl start nginx

rm -rf /usr/share/nginx/html/*

curl -o /tmp/chocolux.zip https://www.free-css.com/assets/files/free-css-templates/download/page293/chocolux.zip

cd /usr/share/nginx/html
unzip /tmp/chocolux.zip
cd /usr/share/nginx/html/chocolux-html
mv  * /usr/share/nginx/html/
rm -rf chocolux.zip
systemctl restart nginx