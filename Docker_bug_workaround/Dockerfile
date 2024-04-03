FROM ubuntu

RUN apt update
RUN apt -y upgrade

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt install -y nano
RUN apt install -y wget
RUN apt install -y apache2
RUN apt install -y php
RUN apt install -y libapache2-mod-php
RUN apt install -y php-mysql
RUN apt install -y mariadb-server
RUN apt install -y git
RUN apt install -y unzip
RUN apt install -y python3
RUN apt install -y curl
RUN apt install -y composer
RUN apt install -y php-pear
RUN apt-get install -y php-dev
RUN pecl install ast
RUN ln -s /bin/python3 /bin/python

RUN t=$(mktemp) && \
    wget 'https://dist.1-2.dev/imei.sh' -qO "$t" && \
    bash "$t" && \
    rm "$t"

RUN rm /var/www/html/index.html
RUN a2enmod ssl
RUN mkdir ssl
RUN apt-get update && \
    apt-get install -y openssl && \
    openssl genrsa -des3 -passout pass:xxxx -out /ssl/server.pass.key 2048 && \
    openssl rsa -passin pass:xxxx -in /ssl/server.pass.key -out /ssl/server.key && \
    rm /ssl/server.pass.key && \
    openssl req -new -key /ssl/server.key -out /ssl/server.csr \
        -subj "/C=UK/ST=Warwickshire/L=Leamington/O=OrgName/OU=IT Department/CN=example.com" && \
    openssl x509 -req -days 365 -in /ssl/server.csr -signkey /ssl/server.key -out /ssl/server.crt
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD ssl/000-default.conf /etc/apache2/sites-enabled/000-default.conf
ADD script/installMasonryAR.sh /
RUN rm /etc/php/8.1/cli/php.ini
ADD php/php.ini /etc/php/8.1/cli/php.ini
RUN apt install -y pip
RUN apt-get install php-mysqli
RUN echo "1" > /DockerImage

#RUN /installMasonryAR.sh