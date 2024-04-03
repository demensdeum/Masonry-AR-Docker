mkdir /Sources
cd /Sources

curl -sL https://deb.nodesource.com/setup_20.x | bash - && apt-get update
apt-get install nodejs -y
npm install -g typescript
npm install --save @types/three
npm install --save @types/dat.gui
pip install gltflib

git clone https://github.com/demensdeum/CleanTerminus.git
cd CleanTerminus
pip install . 
cd ..
git clone https://github.com/demensdeum/Masonry-AR.git
cd Masonry-AR
cd client
wget "https://dl.dropbox.com/scl/fi/cadu0dan20o4lhncfxs7d/assetsCompressed.zip?rlkey=i1i3cb4riuk5kcja5szihhxcp&dl=0" -O assets.zip
unzip assets.zip
rm assets.zip
mv assets assets-src
cd ..
cd server
rm composer.json
rm composer.lock
rm -rf .phan
composer require phan/phan
cd ..
./build_deploy.py

service apache2 start
service mariadb start

PHPMYADMIN_VERSION=5.1.1
wget -O /tmp/phpmyadmin.tar.gz https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.tar.gz
tar xfvz /tmp/phpmyadmin.tar.gz -C /var/www
ln -s /var/www/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages /var/www/phpmyadmin
mv /var/www/phpmyadmin/config.sample.inc.php /var/www/phpmyadmin/config.inc.php

# boy here we go!

mysql -uroot -e "set password for 'root'@'localhost' = PASSWORD('new_password');"
mysql -uroot -pnew_password -e "CREATE DATABASE IF NOT EXISTS masonry_ar"

mysql -u root -pnew_password masonry_ar < /Sources/Masonry-AR/server/sql/entities.sql
mysql -u root -pnew_password masonry_ar < /Sources/Masonry-AR/server/sql/info.sql

echo "Play Develop Enjoy"