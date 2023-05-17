#!/bin/bash

# Determine OS architecture
if [[ "$(uname -m)" == "x86_64" ]]; then
  mysql_package="mysql-server"
else
  mysql_package="mysql-server-5.7"
fi

# Install MySQL
sudo apt-get update
sudo apt-get install -y $mysql_package

# Create "tasklinux" database and insert data
mysql -u root -p -e "CREATE DATABASE tasklinux;"
mysql -u root -p test -e "CREATE TABLE users (id INT NOT NULL AUTO_INCREMENT, name VARCHAR(50), email VARCHAR(50), PRIMARY KEY (id));"
mysql -u root -p test -e "INSERT INTO users (name, email) VALUES ('Mansi Bhatt', 'bhattmansi1212@gmail.com');"
mysql -u root -p test -e "INSERT INTO users (name, email) VALUES ('Aditya','aditya@gmail.com');"

# Take backup of "test" database
mysqldump -u root -p tasklinux > tasklinux.sql

# Create tar file of backup and store it in /tmp directory
tar czf /tmp/tasklinux_backup.tar.gz tasklinux.sql

