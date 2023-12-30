source common.sh
component=backend
echo install nodejs repo
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file
stat_check

echo install nodejs
dnf install nodejs -y &>>$log_file
stat_check

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
stat_check
echo add application user
id expense &>>$log_file
 if [$? -ne 0]; then
    useradd expense &>>$log_file
stat_check

echo clean app content
rm -rf /app &>>$log_file
stat_check
mkdir /app
cd /app

download_and_extract

echo download dependencies
npm install &>>$log_file
stat_check

echo start backend service
systemctl daemon-reload

systemctl enable backend
systemctl start backend
stat_check

echo install mysql client
dnf install mysql -y &>>$log_file
stat_check

echo load schema
mysql -h mysql.malleswaridevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
stat_check