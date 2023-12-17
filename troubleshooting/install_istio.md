
> Installation

```shell
vagrant@master-node:~$ istioctl install
This will install the Istio 1.20.1 "default" profile (with components: Istio core, Istiod, and Ingress gateways) into the cluster. Proceed? (y/N) y
✔ Istio core installed                                                                                                     
✘ Istiod encountered an error: failed to wait for resource: resources not ready after 5m0s: context deadline exceeded      
      
- Processing resources for Ingress gateways. Waiting for Deployment/istio-system/istio-ingressgateway                      
✘ Ingress gateways encountered an error: failed to wait for resource: resources not ready after 5m0s: context deadline exceeded
  Deployment/istio-system/istio-ingressgateway (container failed to start: ContainerCreating: )
- Pruning removed resources                                                                                                Error: failed to install manifests: errors occurred during operation
- 
```

> Troubleshooting

- Check Istio Ingress and Egress Pods
```bash
$ kubectl get pods -n istio-system
```

- Inspect Istio Ingress and Egress Services
```bash
$ kubectl get svc -n istio-system 
```

- Examine the logs of the Istio Ingress and Egress Gateway pods for any error messages
```bash
$ kubectl logs <pod_name> -n <namespace>
```

- Check for any relevant events related to the Istio installation
  
```bash
$ kubectl events -n istio-system -o json
```

"message": "0/3 nodes are available: 1 node(s) had untolerated taint {node-role.kubernetes.io/control-plane: }, 2 Insufficient memory

