dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file

dnf install nodejs -y &>>$log_file

cp backend.service /etc/systemd/system/backend.service &>>$log_file
useradd expense

rm -rf /app &>>$log_file
mkdir /app

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app
unzip /tmp/backend.zip &>>$log_file

cd /app

npm install &>>$log_file

systemctl daemon-reload

systemctl enable backend
systemctl start backend

dnf install mysql -y &>>$log_file
mysql -h mysql.malleswaridevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file