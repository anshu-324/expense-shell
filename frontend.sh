echo install nginx
dnf install nginx -y >>/tmp/expense.log

echo placing expense config file
cp expense.conf /etc/nginx/default.d/expense.conf >>/tmp/expense.log

echo removing old nginx content
rm -rf /usr/share/nginx/html/* >>/tmp/expense.log

echo download frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>/tmp/expense.log

echo extracting frontend code
cd /usr/share/nginx/html >>/tmp/expense.log
unzip /tmp/frontend.zip >>/tmp/expense.log

echo starting nginx service
systemctl enable nginx >>/tmp/expense.log
systemctl start nginx >>/tmp/expense.log
