source common.sh
echo install nodejs repo
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file

echo install nodejs
dnf install nodejs -y &>>$log_file
echo copy backend service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo add application user
useradd expense

echo clean app content
rm -rf /app &>>$log_file
mkdir /app
cd /app

download_and_extract

echo download dependencies
npm install &>>$log_file

echo start backend service
systemctl daemon-reload

systemctl enable backend
systemctl start backend

echo install mysql client
dnf install mysql -y &>>$log_file

echo load schema
mysql -h mysql.malleswaridevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file