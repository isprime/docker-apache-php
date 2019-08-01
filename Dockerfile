FROM ubuntu:12.04
#FROM ubuntu:12.04 change this if you need 5.3, by default it goes to 5.5

MAINTAINER Mauro Delazeri <mauro.delazeri@isprime.com>

VOLUME ["/var/www"]

#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y apache2 supervisor php5 php5-cli libapache2-mod-php5 php5-gd php5-json php5-ldap php5-mysql php5-pgsql vim nano
RUN mkdir -p /www
RUN mkdir -p /var/log/supervisor

RUN useradd ubuntu -d /home/ubuntu

ADD apache_default /etc/apache2/sites-enabled/000-default
RUN a2enmod rewrite
RUN sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php5/apache2/php.ini
RUN sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php5/cli/php.ini
RUN sed -ri 's/^error_reporting\s*=.*$/error_reporting = E_ALL \& ~E_DEPRECATED \& ~E_NOTICE/g' /etc/php5/apache2/php.ini
RUN sed -ri 's/^error_reporting\s*=.*$/error_reporting = E_ALL \& ~E_DEPRECATED \& ~E_NOTICE/g' /etc/php5/cli/php.ini

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD run /usr/local/bin/
RUN chmod +x /usr/local/bin/run
EXPOSE 22 80
CMD ["/usr/local/bin/run"]
