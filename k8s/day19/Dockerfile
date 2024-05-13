FROM oraclelinux:8.4 
RUN yum install httpd -y 
COPY index.html /var/www/html/
RUN mkdir -p /var/log/httpd/{access,error}
COPY httpd.conf /etc/httpd/conf.d/ashu.conf  
ENTRYPOINT [ "httpd","-D","FOREGROUND" ]