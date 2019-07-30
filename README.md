apache-php
===================================

A Docker image based on Ubuntu, serving PHP running as Apache Module. 

Tags
-----

* 5.3.10: Ubuntu 12.04 (LTS), Apache 2.2, PHP 5.3.10
* 5.5.9: Ubuntu 14.04 (LTS), Apache 2.4, PHP 5.5.9

Build
------
```
docker build -t 5.3 .

# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
5.3                 latest              69aaa5df3e01        6 seconds ago       237MB
ubuntu              12.04               5b117edd0b76        2 years ago         104MB

docker tag 69aaa5df3e01 isprimemauro/apache-php:5.3.10

docker push isprimemauro/apache-php:5.3.10

```

Usage
------

```
docker run -d -P isprimemauro/apache-php:5.3.10
```

A bit more specific:

```
docker run -d -p 8080:80 -p 2022:22 -v /www/webroot:/var/www --name=XXXXX -e SERVER_PASSWORD=ubuntu isprimemauro/apache-php:5.3.10

docker run -d -p 8080:80 -p 2022:22 -v /www/webroot:/var/www --name=XXXXX -e SERVER_PASSWORD=ubuntu isprimemauro/apache-php:5.5.9
```

* `-v [local path]:/var/www` maps the container's webroot to a local path
* `-p [local port]:80` maps a local port to the container's HTTP port 80
* `-p [local port]:22` maps a local port to the container's SSH daemon port 22
* `-e SERVER_PASSWORD=[secret]` sets the user passwords for both `root` and the unprivileged `ubuntu` user
* `-e SERVER_KEY=[ssh-key-string]` sets the SSH key for the `ubuntu` user to log in passwordless via ssh

### Reload apache inside of the container

```
apache2ctl -k graceful
```

Installed packages
-------------------
* Ubuntu Server, based on ubuntu docker iamge
* openssh-server
* apache2
* php5
* php5-cli
* libapache2-mod-php5
* php5-gd
* php5-json
* php5-ldap
* php5-mysql
* php5-pgsql

Configurations
----------------

* Apache: .htaccess-Enabled in webroot (mod_rewrite with AllowOverride all)
* php.ini:
  * display_errors = On
  * error_reporting = E_ALL & ~E_DEPRECATED & ~E_NOTICE
