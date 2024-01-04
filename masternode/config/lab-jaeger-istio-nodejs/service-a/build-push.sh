#!/bin/bash

#docker build . -t default-route-openshift-image-registry.apps-crc.testing/default/service-a-nodejs-istio
#docker push default-route-openshift-image-registry.apps-crc.testing/default/service-a-nodejs-istio

docker build . -t danielribeirojr/service-a-nodejs-istio
docker push danielribeirojr/service-a-nodejs-istio
