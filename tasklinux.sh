#!/bin/bash

# Determine the Linux distribution
if grep -q 'Ubuntu' /etc/os-release; then
    echo 'Ubuntu detected'
    # install MySQL on Ubuntu
    sudo apt update
    sudo apt install -y mysql-server
elif grep -q 'Red Hat' /etc/os-release; then
    echo 'RHEL detected'
    # install MySQL on RHEL
    sudo yum update -y
    sudo yum install -y mysql-server
else
    echo 'Unsupported Linux distribution'
    exit 1
fi

# Install MySQL
#sudo apt-get update
#sudo apt-get install -y $mysql_package

# Create "tasklinux" database and insert data
mysql -u root -p -e "CREATE DATABASE tasklinux;"
mysql -u root -p test -e "CREATE TABLE users (id INT NOT NULL AUTO_INCREMENT, name VARCHAR(50), email VARCHAR(50), PRIMARY KEY (id));"
mysql -u root -p test -e "INSERT INTO users (name, email) VALUES ('Mansi Bhatt', 'bhattmansi1212@gmail.com');"
mysql -u root -p test -e "INSERT INTO users (name, email) VALUES ('Aditya','aditya@gmail.com');"

# Take backup of "test" database
mysqldump -u root -p tasklinux > tasklinux.sql

# Create tar file of backup and store it in /tmp directory
tar czf /tmp/tasklinux_backup.tar.gz tasklinux.sql

