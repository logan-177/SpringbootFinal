#!/bin/bash


echo "Starting Minikube..."
minikube status | grep "host" | grep "Running" >/dev/null 2>&1
if [ $? -ne 0 ]; then
    minikube start
else
    echo "Minikube is already running."
fi

echo "Applying PersistentVolume and PersistentVolumeClaim..."
kubectl apply -f k8s-pv.yaml

echo "Applying Deployment and Service..."
kubectl apply -f k8s-webapp.yaml


echo "Waiting for pod to be ready..."
kubectl wait --for=condition=Ready pod -l app=demo-webapp --timeout=60s


echo "Checking ConfigMaps..."
kubectl get configmap

echo "Checking Deployments..."
kubectl get deployments

echo "Checking Services..."
kubectl get svc
