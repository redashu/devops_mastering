FROM oraclelinux:8.4 
LABEL name="ashutoshh"
ARG soft=httpd
ENV app=env1 
# above we have defined app as variable and env1 as value
RUN dnf install ${soft} -y 
RUN mkdir  -p  /webapp/{app1,app2}
COPY Netflix-Website-Project /webapp/app1/
COPY html5-simple-personal-website /webapp/app2/
COPY deploy.sh  /webapp/
WORKDIR /webapp
RUN chmod +x  deploy.sh 
ENTRYPOINT [ "./deploy.sh" ]
