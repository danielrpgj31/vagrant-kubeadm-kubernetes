#!/bin/bash

#docker build . -t default-route-openshift-image-registry.apps-crc.testing/default/service-a-nodejs-istio
#docker push default-route-openshift-image-registry.apps-crc.testing/default/service-a-nodejs-istio

#docker build . -t csantanapr/service-a-nodejs-istio
#docker push csantanapr/service-a-nodejs-istio

# Versão podman
sudo podman build -t service-a-nodejs .
#sudo podman tag service-a-nodejs registry.example.com/service-a-nodejs:v1
