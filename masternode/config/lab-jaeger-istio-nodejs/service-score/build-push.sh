#!/bin/bash

#docker build . -t default-route-openshift-image-registry.apps-crc.testing/default/service-b-nodejs-istio
#docker push default-route-openshift-image-registry.apps-crc.testing/default/service-b-nodejs-istio

docker build . -t danielribeirojr/service-score-nodejs-istio
docker push danielribeirojr/service-score-nodejs-istio