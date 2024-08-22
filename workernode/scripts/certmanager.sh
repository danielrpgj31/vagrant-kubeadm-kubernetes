#!/bin/bash
#
# Setup for K8S Certmanager
# Prereq: K8S master and worker nodes

# Install certmanager 
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.0/cert-manager.yaml
