### creating container with env 

### webapp URL 

```
git clone https://github.com/website-template/html5-simple-personal-website.git
git clone https://github.com/pro-prodipto/Netflix-Website-Project.git
```

```
04  docker build -t  ashuwebapp:v1  . 
  105  docker images
  106  docker  run -d --name webc1 -p 1234:80  14aa4d27455c 
  107  docker  ps
  108  docker  run -d --name webc2 -e  app=dev  -p 1235:80  14aa4d27455c 
  109  docker  ps
  110  docker  run -d --name webc2 -e  app=deprod-p 1235:60  14aa4d27455c 
  111  docker  run -d --name webc3 -e  app=deprod-p 1235:60  14aa4d27455c 
  112  docker  run -d --name webc3 -e  app=deprod-p 1235:80  14aa4d27455c 
  113  docker  run -d --name webc3 -e  app=prod -p 1236:80  14aa4d27455c 
```

### mutistage dockerfil

```
FROM maven AS builder 
WORKDIR /new
COPY hello.java . 
RUN mvn build -output helloapp.war  

FROM zapp AS Scanner 
WORKDIR /code  
COPY --from=builder /new/helloapp.war  /code/ 
RUN zapp scan  /code/helloapp.war --output fixcode.war 

FROM tomcat
COPY --from=Scanner /code/fixcode.war  /usr/local/tomcat/webapps/

```
