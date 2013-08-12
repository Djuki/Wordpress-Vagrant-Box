Wordpress Vagrant Box
====================
## Introduction

This is Vagrant box for Wordpress developers. This box has the minimal requirements to run Wordpress. This box will get latest Wordpres, set up the database and install the Wordpress for you.

Minimal PHP version is ideal for WP development. You can't use latest features and function, and you will be sure that you plugins will work on any Wordpress platform.

## What's inside this Vagrant box ?

LAMP is powered by Bitnami LAMP stack installer version 1.2-5 and

Inside the Box is
- Apache 2.2
- PHP 5.2.17
- MySQL 5.1.56
- phpMyAdmin 2.11.11.3
- libmcrypt 1.2.8
- Latest Wordpress

## How to install

1 - Clone this respository

    git clone https://github.com/Djuki/Wordpress-Vagrant-Box.git

2 - Go into the box directory

    cd Wordpress-Vagrant-Box

3 - Run the vagrant command

    vagrant up

After this wait while the puppet provisioning your vagrant server. When it is done your wordpress installation will be located into `Wordpress-Vagrant-Box/www/wordpress`.

## Box Details

### Wordpress

You can access to wordpress via http://33.33.33.111/

user: admin
password : avantime

### MySQl

user: root
password: avanti


### PhpMyAdmin
access via http://33.33.33.111/phpmyadmin/

No password required


## Bitnami lampstack commands

### stop the lamp stack

    /home/vagrant/lampstack/ctlscript.sh stop

### start the lamp stack

    /home/vagrant/lampstack/ctlscript.sh start

### mysql shell

    /home/vagrant/lampstack/mysql/bin/mysql -uroot -p$avanti

### apache configuration file location

    /home/vagrant/apache2/conf/httpd.conf