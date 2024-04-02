FROM ubuntu

RUN apt update
RUN apt -y upgrade

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
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

RUN apt-get update && apt-get install -y wget && \
    apt-get install -y autoconf pkg-config

RUN apt-get update && apt-get install -y wget && \
    apt-get install -y build-essential curl libpng-dev && \
    wget https://github.com/ImageMagick/ImageMagick/archive/refs/tags/7.1.0-31.tar.gz && \
    tar xzf 7.1.0-31.tar.gz && \
    rm 7.1.0-31.tar.gz && \
    apt-get clean && \
    apt-get autoremove

RUN sh ./ImageMagick-7.1.0-31/configure --prefix=/usr/local --with-bzlib=yes --with-fontconfig=yes --with-freetype=yes --with-gslib=yes --with-gvc=yes --with-jpeg=yes --with-jp2=yes --with-png=yes --with-tiff=yes --with-xml=yes --with-gs-font-dir=yes && \
    make -j && make install && ldconfig /usr/local/lib/

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

#run git clone https://github.com/demensdeum/CleanTerminus.git
#run git clone https://github.com/demensdeum/Masonry-AR.git

#run wget "https://www.dropbox.com/scl/fi/c451cddhkxpyz3rxgyomo/assetsCompressed.zip?rlkey=dnzt1tosz6ixc12i27fs7gh5h&dl=0" -O assets.zip
#run unzip /assets.zip -d /Masonry-AR
#run mv -v /Masonry-AR /var/www/html/Masonry-AR


#run service apache2 start