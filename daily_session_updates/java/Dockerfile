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
