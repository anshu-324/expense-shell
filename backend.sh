#source common.sh
component=backend
#echo install nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash


#echo install nodejs
dnf install nodejs -y


#echo copy backend service file
cp backend.service /etc/systemd/system/backend.service


#echo add application user
useradd expense


#echo clean app content
rm -rf /app

mkdir /app
cd /app

download_and_extract


#echo download dependencies
npm install


#echo start backend service
systemctl daemon-reload
systemctl enable backend
systemctl start backend


#echo install mysql client
dnf install mysql -y


#echo load schema
mysql -h mysql.malleswaridevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql
