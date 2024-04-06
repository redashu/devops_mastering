FROM oraclelinux:8.4 AS Builder
LABEL name=ashutoshh
ENV mydir=ashu-java
RUN dnf install java-1.8.0-openjdk java-1.8.0-openjdk-devel  maven  -y 
RUN mkdir /${mydir}
WORKDIR /${mydir}
COPY . .  

# now running maven to create .war file 
RUN mvn install  \ 
&& ls target 
FROM tomcat
LABEL email="ashutoshh@linux.com"
COPY --from=Builder /mydir/target/WebApp.war /usr/local/tomcat/webapps/
