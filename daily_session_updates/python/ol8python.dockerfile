FROM oraclelinux:8.4  
# pulling python image from docker hub 
ENV  myenv=new 
# env is for while creating container 
ARG  pkg=softwae
# ARG  is for during build time 
LABEL name=ashutoshh
LABEL email=ashutoshh@linux.com 
RUN dnf install $pkg  -y 
RUN mkdir -p /opt/mycode/ 
RUN useradd test
COPY *.py /opt/mycode/
COPY callenv.sh /opt/mycode/
WORKDIR /opt/mycode
RUN chmod +x callenv.sh 
# changing directory for image during build time 
USER test 
# for non root user 1000-60000 
#CMD ["python3","hello.py"]
#ENTRYPOINT  ["python3","hello.py"] 
CMD [ "hello.py" ]
ENTRYPOINT [ "python3" ]
# python3  hello.py 
# We can replace cmd statement while creating container 
# only one CMD we can use since container is accepting single process 