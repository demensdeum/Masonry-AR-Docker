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
wget "https://s263vlx.storage.yandex.net/rdisk/378c7ab9b1ceaa6069cf28c6b3dfaacbb03801dde44190e66d7857c30944a7f0/660c82f6/QeKFHQJtUNoi68klEHJqeKSZdd1YUV5YynDl5obHvPorG6oz0TBzVT8W4MbOGi00yHwBvmLJOf1RI0vtjSGMeA==?uid=1405195644&filename=assetsCompressed.zip&disposition=attachment&hash=&limit=0&content_type=application%2Fzip&owner_uid=1405195644&fsize=112047015&hid=0c91073555eccc269f7c49af1722b2cc&media_type=compressed&tknv=v2&etag=97ca710186d67300147a0e2cee072a8f&ts=61524694e2980&s=8ccf2fc523e61c3c5094b912972483572e7e53e6375eefb43700679d9b8f8c1a&pb=U2FsdGVkX1_5M5qDZqsYrCraZqCBwDPnwYcBHyDoSibD6jCOptIz9KGoOlBGy2ZD_WSKY6iEdle9moBxhRWhoEPvMIMcVQVXlp7W0fuzacU" -O assets.zip
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