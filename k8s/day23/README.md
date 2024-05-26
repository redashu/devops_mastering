# devops_mastering 

## Notes 

### killercoda 
[click_to_access](https://killercoda.com/)

### kodeCloud 

[click_to_access](https://kodekloud.com/)

## Helm package Architecture 

<img src="heml1.png">

### updating setting file while deploying app using helm 

```
humanfirmware@darwin  ~/Desktop  helm install ashua-pps ashu-devopstech/nginx --set service.type=ClusterIP

==verify it 
humanfirmware@darwin  ~/Desktop  helm ls
NAME     	NAMESPACE	REVISION	UPDATED                             	STATUS  	CHART       	APP VERSION
ashua-pps	default  	1       	2024-05-26 09:20:23.593999 +0530 IST	deployed	nginx-17.3.0	1.26.0     
 humanfirmware@darwin  ~/Desktop  kubectl  get deploy
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
ashua-pps-nginx   1/1     1            1           20s
 humanfirmware@darwin  ~/Desktop  kubectl get po 
NAME                               READY   STATUS    RESTARTS   AGE
ashua-pps-nginx-5bfd58bc59-ff4xd   1/1     Running   0          24s
 humanfirmware@darwin  ~/Desktop  kubectl get svc
NAME              TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
kubernetes        ClusterIP   10.43.0.1      <none>        443/TCP          23h
ashua-pps-nginx   ClusterIP   10.43.196.54   <none>        80/TCP,443/TCP   27s

```
### Deploying app using values.yml

```
 helm install ashua-pps ashu-devopstech/nginx --values day23/values.yaml
```

## Creating helm chart 

```
 humanfirmware@darwin  ~/devops_mastering/k8s/day23   master  
 humanfirmware@darwin  ~/devops_mastering/k8s/day23   master  helm create  ashu-ui
Creating ashu-ui
 humanfirmware@darwin  ~/devops_mastering/k8s/day23   master  ls
README.md   ashu-ui     ashu.yml    values.yaml
 humanfirmware@darwin  ~/devops_mastering/k8s/day23   master  tree  ashu-ui 
ashu-ui
├── Chart.yaml
├── charts
├── templates
│   ├── NOTES.txt
│   ├── _helpers.tpl
│   ├── deployment.yaml
│   ├── hpa.yaml
│   ├── ingress.yaml
│   ├── service.yaml
│   ├── serviceaccount.yaml
│   └── tests
│       └── test-connection.yaml
└── values.yaml

4 directories, 10 files
```

### deploying app using local helm chart 

```
helm install mohit-app  ./ashu-ui 
```

### helm pull

```
helm pull   ashu-devopstech/nginx
```

### helm upgrade

```
 humanfirmware@darwin  ~/devops_mastering/k8s/day23   master  helm ls
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
mohit-app       default         1               2024-05-26 09:53:47.522637 +0530 IST    deployed        ashu-ui-0.1.0   1.16.0     
 humanfirmware@darwin  ~/devops_mastering/k8s/day23   master  helm upgrade  mohit-app ./ashu-ui 
Release "mohit-app" has been upgraded. Happy Helming!
NAME: mohit-app
LAST DEPLOYED: Sun May 26 09:54:18 2024
NAMESPACE: default
STATUS: deployed
REVISION: 2
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=ashu-ui,app.kubernetes.io/instance=mohit-app" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
```

## helm rollbacking 

```
humanfirmware@darwin  ~/Desktop  helm history mohit-app 
REVISION	UPDATED                 	STATUS    	CHART        	APP VERSION	DESCRIPTION     
1       	Sun May 26 09:53:47 2024	superseded	ashu-ui-0.1.0	1.16.0     	Install complete
2       	Sun May 26 09:54:18 2024	deployed  	ashu-ui-0.1.0	1.16.0     	Upgrade complete
 humanfirmware@darwin  ~/Desktop  
 humanfirmware@darwin  ~/Desktop  
 humanfirmware@darwin  ~/Desktop  helm ls
NAME     	NAMESPACE	REVISION	UPDATED                             	STATUS  	CHART        	APP VERSION
mohit-app	default  	2       	2024-05-26 09:54:18.671151 +0530 IST	deployed	ashu-ui-0.1.0	1.16.0     
 humanfirmware@darwin  ~/Desktop  helm rollback  mohit-app 1
Rollback was a success! Happy Helming!
 humanfirmware@darwin  ~/Desktop  kubectl  get po 
NAME                                 READY   STATUS    RESTARTS   AGE
mohit-app-ashu-ui-59d7ff444b-z72tp   1/1     Running   0          10m
 humanfirmware@darwin  ~/Desktop  

```

