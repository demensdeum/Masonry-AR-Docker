# Masonry-AR-Docker
Masonry-AR-Docker

Dockerfile for LAMP + Masonry-AR client, server  

Build:  
./buildImage.sh  
Run Environment:  
docker run -p 8080:80 -it  <image_id>  
Install:  
/installMasonryAR.sh  
Test: 
open https://localhost:8080/Masonry-AR/client/ in browser on host machine  
accept self-signed ssl certificate  
if there is error about outdated uuid, then open https://localhost:8080/Masonry-AR/server/logout.php first

Here is also Docker bug, that could be reproduces from root Dockerfile:  
https://forums.docker.com/t/docker-stops-responding-on-macos-error-on-arch-linux-while-building-image/140650  

workaround is to use Imagemagick 7 easy installer https://github.com/SoftCreatR/imei, this workaround is using in Docker_bug_workaround/Dockerfile