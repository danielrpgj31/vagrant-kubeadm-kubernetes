> Ingress Controller 

Implementa a API de Ingress do K8S:

Nginx Ingress Controller
Traefik
HAProxy Ingress
Etc..

> Instalacao

```bash
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

$ kubectl get pods -n ingress-nginx
NAME                                        READY   STATUS      RESTARTS   AGE
ingress-nginx-admission-create-t4s7j        0/1     Completed   0          16m
ingress-nginx-admission-patch-z2dcw         0/1     Completed   0          16m
ingress-nginx-controller-7cb7b799bd-95nrw   1/1     Running     0          16m
```

