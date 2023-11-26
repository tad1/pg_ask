sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
sudo ufw allow "Apache Full"
sudo a2enmod ssl

cp ./apache2.conf /etc/apache2/apache2.conf
systemctl restart apache2