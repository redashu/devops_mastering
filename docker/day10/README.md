# devops_mastering
### docker compose we can run it using given command

```
day10 git:(master) ✗ ls
Dockerfile          docker-compose.yaml hello.java          web.dockerfile
README.md           hello.html          hello.py
➜  day10 git:(master) ✗ docker-compose up -d 
[+] Running 2/2
 ! ashuwebapp Warning                                                                                                      13.6s 
 ! ashupythonapp Warning                                                                                                   13.7s 
[+] Building 17.6s (15/15) FINISHED                                                                       docker:rancher-desktop
 => [ashupythonapp internal] load build definition from Dockerfile                                                          0.1s
 => => transferring dockerfile: 144B     

 ====>>
 day10 git:(master) ✗ docker-compose ps    
NAME         IMAGE             COMMAND                  SERVICE         CREATED         STATUS         PORTS
ashucc1122   ashupython:v1     "python3 hello.py"       ashupythonapp   7 seconds ago   Up 6 seconds   
ashuwebc2    ashuwebapp:v1.0   "/docker-entrypoint.…"   ashuwebapp      7 seconds ago   Up 6 seconds   80/tcp                    
```
## deleting everything by compose

```
day10 git:(master) ✗ docker-compose down
[+] Running 1/2
 ✔ Container ashuwebc2   Removed                                                                                            0.4s 
 ⠦ Container ashucc1122  Stopping               
```
## more command 

```
day10 git:(master) ✗ docker-compose ps    
NAME         IMAGE             COMMAND                  SERVICE         CREATED         STATUS         PORTS
ashucc1122   ashupython:v1     "python3 hello.py"       ashupythonapp   4 seconds ago   Up 3 seconds   
ashuwebc2    ashuwebapp:v1.0   "/docker-entrypoint.…"   ashuwebapp      4 seconds ago   Up 3 seconds   80/tcp
➜  day10 git:(master) ✗ docker-compose down ashupythonapp 
[+] Running 2/1
 ✔ Container ashucc1122   Removed                                                                                          10.4s 
 ! Network day10_default  Resource is still in use                                                                          0.0s 
➜  day10 git:(master) ✗ docker-compose ps                 
NAME        IMAGE             COMMAND                  SERVICE      CREATED          STATUS          PORTS
ashuwebc2   ashuwebapp:v1.0   "/docker-entrypoint.…"   ashuwebapp   29 seconds ago   Up 28 seconds   80/tcp
➜  day10 git:(master) ✗ docker-compose up -d              
[+] Running 2/2
 ✔ Container ashucc1122  Started                                                                                            0.0s 
 ✔ Container ashuwebc2   Running                                                                                            0.0s 
➜  day10 git:(master) ✗ docker-compose ps   
NAME         IMAGE             COMMAND                  SERVICE         CREATED          STATUS          PORTS
ashucc1122   ashupython:v1     "python3 hello.py"       ashupythonapp   2 seconds ago    Up 2 seconds    
ashuwebc2    ashuwebapp:v1.0   "/docker-entrypoint.…"   ashuwebapp      40 seconds ago   Up 39 seconds   80/tcp
```

### compose more command 

```
0036  docker-compose  -f  ashu-compose.yml up -d 
10037  docker-compose  -f  ashu-compose.yml ps
10038  docker-compose  -f  ashu-compose.yml  stop 
10039  docker-compose  -f  ashu-compose.yml  start
10040  docker-compose  -f  ashu-compose.yml  ps
10041  docker-compose  -f  ashu-compose.yml  exec -it ashupythonapp1  bash 
10042  docker-compose  -f  ashu-compose.yml  exec -it ashupythonapp1  sh
```

## Introduction to container Storage 

### docker volume 
```
docker  volume  create  ashuvol1
```
### creating conatiner

```
docker run -itd --name c2  -v  ashuvol1:/mnt/ashu  alpine 
7e066798a48b678e8d38ef6f0d9d1d332225e9c7a3735b44689fbe84d93a4062
```

### updating data

```
 day10 git:(master) ✗ docker run -itd --name c2  -v  ashuvol1:/mnt/ashu  alpine 
7e066798a48b678e8d38ef6f0d9d1d332225e9c7a3735b44689fbe84d93a4062
➜  day10 git:(master) ✗ docker  exec -it  c2 sh 
/ # cd /mnt/ashu/
/mnt/ashu # ls
/mnt/ashu # mkdir hello hii
/mnt/ashu # ls
hello  hii
/mnt/ashu # exit
```
### checking 

```
day10 git:(master) ✗ docker rm c2 -f
c2
➜  day10 git:(master) ✗ 
➜  day10 git:(master) ✗ docker  volume  ls
DRIVER    VOLUME NAME
local     ashuvol1
```
### lets see 

```
 day10 git:(master) ✗ docker run -itd --name c2  -v  ashuvol1:/mnt/ashu  alpine 
fb2a9931113a075f1c8ba3fb0c38f8cd2ddf481c093b7328c820cdb9013e48bc
➜  day10 git:(master) ✗ 
➜  day10 git:(master) ✗ 
➜  day10 git:(master) ✗ docker  exec -it  c2 sh                                   
/ # 
/ # ls  /mnt/ashu/
hello  hii
/ # exit
```

### same multiple container 

```
 day10 git:(master) ✗ docker  run -itd --name c4 -v ashuvol1:/opt/new  oraclelinux:8.4 bash 
bba9ac4e471a8a2f8974c85c365592655959b45b46da4d58be02709c23d2f11d
➜  day10 git:(master) ✗ docker exec -it  c4 bash 
[root@bba9ac4e471a /]# cd /opt/new/
[root@bba9ac4e471a new]# ls
hello  hii
[root@bba9ac4e471a new]# mkdir mmee
[root@bba9ac4e471a new]# ls
hello  hii  mmee
[root@bba9ac4e471a new]# exit
exit
```
