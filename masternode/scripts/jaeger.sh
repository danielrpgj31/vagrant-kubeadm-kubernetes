#!/bin/bash
#
# Setup for K8S Jaeger Distributed Tracing Solution

# Install certmanager 
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.0/cert-manager.yaml

# Install jaeger operator on namespace 'observability'
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
kubectl create ns observability

# Create jaeger operator instance
kubectl apply -f jaeger.yaml

