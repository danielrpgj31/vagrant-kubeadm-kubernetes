#!/bin/bash
#
# Setup for K8S Jaeger Distributed Tracing Solution
# Prereq: Certmanager e Helm

# Install jaeger operator on namespace 'observability'
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts

kubectl create ns observability
helm install my-release jaegertracing/jaeger-operator -n observability

# Create jaeger operator instance
kubectl apply -f ./jaeger.yaml

