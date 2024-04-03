# Masonry-AR-Docker
Masonry-AR-Docker
  
Inspired by: https://github.com/mattrayner/docker-lamp/ 
  
Dockerfile for LAMP + [Masonry-AR](https://github.com/demensdeum/Masonry-AR) client, server  
  
Build:  
./buildImage.sh  
  
Run Environment:  
docker run -p 8080:80 -it  <image_id>  
  
Install:  
/installMasonryAR.sh  
  
Test:  
- open https://localhost:8080/Masonry-AR/client/ in browser on host machine (**secure https is important! otherwise game will not work on some devices, for example iOS devices because of strict security for geolocation data**), open with unsecured protocol http will lead to Bad Request error.  
- accept self-signed ssl certificate  
- if there is error about outdated uuid, then open https://localhost:8080/Masonry-AR/server/logout.php first  
  
Here is also Docker bug, that could be reproduced from root Dockerfile:  
https://forums.docker.com/t/docker-stops-responding-on-macos-error-on-arch-linux-while-building-image/140650  

workaround is to use Imagemagick 7 easy installer https://github.com/SoftCreatR/imei, workaround is using in Docker_bug_workaround/Dockerfile  
  
Extra:  
- phpMyAdmin https://localhost:8080/phpmyadmin/  
- credentials: root / new_password  
  
Play Develop Enjoy