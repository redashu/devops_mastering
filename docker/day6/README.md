# devops_mastering

### updated dockerfile 

```
FROM oraclelinux:8.4  
# pulling python image from docker hub 
LABEL name=ashutoshh
LABEL email=ashutoshh@linux.com 
RUN dnf install python3 -y 
RUN mkdir -p /opt/mycode/
COPY *.py /opt/mycode/
CMD ["python3","/opt/mycode/hello.py"] 
# We can replace cmd statement while creating container 
```

### we  can replace cmd statement while creating container 

```
 docker run -itd --name c2  ashupy:v1   python3  /opt/mycode/ok.py  
```

### rootless container image 

```
FROM oraclelinux:8.4  
# pulling python image from docker hub 
LABEL name=ashutoshh
LABEL email=ashutoshh@linux.com 
RUN dnf install python3 -y 
RUN mkdir -p /opt/mycode/
COPY *.py /opt/mycode/
USER 1001 
# for non root user 1000-60000 
CMD ["python3","/opt/mycode/hello.py"] 
# We can replace cmd statement while creating container 
```

### build & test 

```
t3@docker-server python]$ docker build -t ashupy:rootlessv1   -f ol8python.dockerfile  . 
Sending build context to Docker daemon   5.12kB
Step 1/8 : FROM oraclelinux:8.4
 ---> 97e22ab49eea
Step 2/8 : LABEL name=ashutoshh

====>>
t3@docker-server ashu-images]$ docker run -itd --name c3  ashupy:rootlessv1
efb291c89bef5ae5cd85493b739619e256b23f2f23ca1c4c25e69d9230f1550e
[t3@docker-server ashu-images]$ docker  exec -it  c3 bash 
bash-4.4$ whoami
whoami: cannot find name for user ID 1001
bash-4.4$ id
uid=1001 gid=0(root) groups=0(root)
bash-4.4$ mkdir  /okskdf
mkdir: cannot create directory '/okskdf': Permission denied
bash-4.4$ exit
exit
```

### we can create a particular user 

```
FROM oraclelinux:8.4  
# pulling python image from docker hub 
LABEL name=ashutoshh
LABEL email=ashutoshh@linux.com 
RUN dnf install python3 -y 
RUN mkdir -p /opt/mycode/ 
RUN useradd test
COPY *.py /opt/mycode/
USER test 
# for non root user 1000-60000 
CMD ["python3","/opt/mycode/hello.py"] 
# We can replace cmd statement while creating container 
```

### more detail

```
FROM oraclelinux:8.4  
# pulling python image from docker hub 
LABEL name=ashutoshh
LABEL email=ashutoshh@linux.com 
RUN dnf install python3 -y 
RUN mkdir -p /opt/mycode/ 
RUN useradd test
COPY *.py /opt/mycode/
WORKDIR /opt/mycode
# changing directory for image during build time 
USER test 
# for non root user 1000-60000 
CMD ["python3","hello.py"] 
# We can replace cmd statement while creating container 
```

### tip to remove and stop container 

```
  docker  kill    $(docker  ps  -q )
   64  docker  rm     $(docker  ps  -aq )
```

### using ENTRYPOINT and CMD 

```
FROM oraclelinux:8.4  
# pulling python image from docker hub 
LABEL name=ashutoshh
LABEL email=ashutoshh@linux.com 
RUN dnf install python3 -y 
RUN mkdir -p /opt/mycode/ 
RUN useradd test
COPY *.py /opt/mycode/
WORKDIR /opt/mycode
# changing directory for image during build time 
USER test 
# for non root user 1000-60000 
#CMD ["python3","hello.py"]
#ENTRYPOINT  ["python3","hello.py"] 
ENTRYPOINT [ "python3" ]
CMD [ "hello.py" ]
# We can replace cmd statement while creating container 
# only one CMD we can use since container is accepting single process 
```


