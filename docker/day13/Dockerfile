FROM alpine AS Builder
RUN install and download 

FROM Builder  as Config 
COPY my.cnf  /etc/mysqld/my.cnf 
EXPOSE 3306

FROM zapper as security 
COPY --from=Config /etc/mysqld/my.cf /opt/ 
RUN zap /opt/my.cnf --output /tmp/my.cnf 

FROM Config
COPY --from=security /tmp/my.cnf /etc/mysqld/
WORKDIR /scripts/
COPY  startmysqld.sh /scripts/
CMD [ "bash","/scripts/startmysqld.sh" ]