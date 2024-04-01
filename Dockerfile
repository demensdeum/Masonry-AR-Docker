FROM nginx:stable-alpine3.17
COPY src /usr/share/nginx/html 
CMD ["nginx", "-g", "daemon off;"]