### container networking 

<img src="cnet.png">

## docker will be using Container networking model (CNM)

### understanding default behaviour of container networking 
<img src="cnet2.png">

## list of networks

```
docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
b9b5a7abae3a   bridge    bridge    local
185a0f66b49a   host      host      local
30987d39b1c7   none      null      local
➜  docker git:(master) ✗ 


```

### inspect 

```
docker git:(master) ✗ docker  network inspect  b9b5a7abae3a
[
    {
        "Name": "bridge",
        "Id": "b9b5a7abae3a5555fdd53c4dd216d11386bdf53fd6aa3958b1aadf24ab5e1a52",
        "Created": "2024-03-20T10:13:23.53124405Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }

```
### lets creating contaner 

```
10168  docker  run -itd --name c1 alpine 
10169  docker ps
10170  docker  network inspect  b9b5a7abae3a
10171  docker  run -itd --name c2 alpine 

 docker git:(master) ✗ docker exec -it c1 sh 
/ # 
/ # 
/ # ping  172.17.0.3
PING 172.17.0.3 (172.17.0.3): 56 data bytes
64 bytes from 172.17.0.3: seq=0 ttl=64 time=2.639 ms
64 bytes from 172.17.0.3: seq=1 ttl=64 time=0.294 ms
^C
--- 172.17.0.3 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.294/1.466/2.639 ms
/ # ping  172.17.0.2
PING 172.17.0.2 (172.17.0.2): 56 data bytes
64 bytes from 172.17.0.2:
```

### by default internal communication is permitted

```
 docker git:(master) ✗ docker run -d --name webui     nginx 
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
59f5764b1f6d: Already exists 
f7bd43626fa7: Already exists 
2df415630b2f: Already exists 
059f9f6918db: Already exists 
df91ff398a83: Already exists 
e75b854d63f1: Already exists 
4b88df8a13cd: Already exists 
Digest: sha256:6db391d1c0cfb30588ba0bf72ea999404f2764febf0f1f196acd5867ac7efa7e
Status: Downloaded newer image for nginx:latest
01443d4d5ef61084649865da411a8ac6ed18b4f0ba6122b54e6140a3f2681e72
➜  docker git:(master) ✗ docker exec -it c1 sh 
/ # curl  http://172.17.0.4
sh: curl: not found
/ # apk add curl 
fetch https://dl-cdn.alpinelinux.org/alpine/v3.19/main/aarch64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.19/community/aarch64/APKINDEX.tar.gz
(1/8) Installing ca-certificates (20240226-r0)
(2/8) Installing brotli-libs (1.1.0-r1)
(3/8) Installing c-ares (1.27.0-r0)
(4/8) Installing libunistring (1.1-r2)
(5/8) Installing libidn2 (2.3.4-r4)
(6/8) Installing nghttp2-libs (1.58.0-r0)
(7/8) Installing libcurl (8.5.0-r0)
(8/8) Installing curl (8.5.0-r0)
Executing busybox-1.36.1-r15.trigger
Executing ca-certificates-20240226-r0.trigger
OK: 13 MiB in 23 packages
/ # 
/ # 
/ # curl  http://172.17.0.4
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

```

### doing port forwarding 

```
docker run -d --name webui1 -p 1111:80     nginx 
2dcaa42e78ef6b74ab863ae297bbbc41dd619797fe5f1df87e5ee9a4181552a1
```

### we can explose multiple ports

```
docker run -d --name webui2 -p 1110:80 -p 2220:81      nginx 
2ea5d20b2ec729cae1f0320f8e44c4f451b7074bc5fd48807f2a79a8fe82d1e0
```

### creating custom bridge 

```
 docker git:(master) ✗ docker network create  br1
60daec075698bfbb30df14837e8f0f998abaf23c77e1b89c27d257fb8ac27cba
➜  docker git:(master) ✗ docker network ls         
NETWORK ID     NAME      DRIVER    SCOPE
60daec075698   br1       bridge    local
b9b5a7abae3a   bridge    bridge    local
185a0f66b49a   host      host      local
30987d39b1c7   none      null      local
➜  docker git:(master) ✗ docker network inspect br1
[
    {
        "Name": "br1",
        "Id": "60daec075698bfbb30df14837e8f0f998abaf23c77e1b89c27d257fb8ac27cba",
        "Created": "2024-04-07T05:27:23.116411353Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.31.0.0/16",
                    "Gateway": "172.31.0.1"
                }

```

### creating custom bridge with subnet 

```
 docker network create  br2 --subnet 192.168.100.0/24
4166fccb4e2f4c806b58bd0a422ff140a145babd47804e3f864578f702d07a56
➜  docker git:(master) ✗ 
➜  docker git:(master) ✗ docker network inspect br2                          
[
    {
        "Name": "br2",
        "Id": "4166fccb4e2f4c806b58bd0a422ff140a145babd47804e3f864578f702d07a56",
        "Created": "2024-04-07T05:28:10.457219834Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "192.168.100.0/24"
                }
            ]

```

### across the bridge communication is not possible 

```
93  docker run -itd --name c3  --network  br1  alpine 
10194  docker run -itd --name c4  --network  br1  alpine 
```

### in Custom bridge container can access to each other by names

```
 docker git:(master) ✗ docker  exec -it c3 sh 
/ # 
/ # 
/ # ping  c4 
PING c4 (172.31.0.3): 56 data bytes
64 bytes from 172.31.0.3: seq=0 ttl=64 time=1.476 ms
64 bytes from 172.31.0.3: seq=1 ttl=64 time=0.261 ms
64 bytes from 172.31.0.3: seq=2 ttl=64 time=0.392 ms
^C
--- c4 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.261/0.709/1.476 ms
/ # exit
➜  docker git:(master) ✗ 
➜  docker git:(master) ✗ docker  exec -it c2 sh 
/ # ping c1
ping: bad address 'c1'
/ # 

```

### container with no network access

```
 docker git:(master) ✗ docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
60daec075698   br1       bridge    local
4166fccb4e2f   br2       bridge    local
b9b5a7abae3a   bridge    bridge    local
185a0f66b49a   host      host      local
30987d39b1c7   none      null      local

➜  docker git:(master) ✗ 
➜  docker git:(master) ✗ docker run -it --rm  --network none  alpine sh 
/ # ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8): 56 data bytes
ping: sendto: Network unreachable
/ # 
/ # ping  172.17.0.2
PING 172.17.0.2 (172.17.0.2): 56 data bytes
ping: sendto: Network unreachable
/ # 

```
### host bridge 

<img src="host1.png">


### 

```
docker run -it --rm  --network host   alpine sh 
```
