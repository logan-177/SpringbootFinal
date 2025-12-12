This project demonstrates deploying a Spring Boot web application in a local Kubernetes cluster (Minikube) using Docker. It includes PersistentVolume (PV) and PersistentVolumeClaim (PVC) configuration, automated deployment scripts, and service exposure via NodePort. The project simulates a standard DevOps deployment pipeline: build JAR ➔ Docker image ➔ Kubernetes deployment.

## Attributes

* Spring Boot REST endpoint (`/hello`) confirming the app is running
* Docker image containing the compiled JAR
* Kubernetes Deployment and Service for application management
* Persistent storage using PV and PVC
* Automation via a shell script (`deploy-all.sh`) for Minikube setup and resource deployment

## Requirements

* [Minikube](https://minikube.sigs.k8s.io/docs/)
* [Docker](https://www.docker.com/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/)
* Maven for building the JAR



```
SpringbootFinal/
├── target/                  # Compiled JAR and build artifacts
├── src/                     # Java source code
├── Dockerfile               # Builds Docker image with JAR
├── k8s-webapp.yaml          # Deployment and Service manifests
├── k8s-pv.yaml              # PersistentVolume and PersistentVolumeClaim manifests
├── deploy-all.sh            # Automated deployment script
└── README.md
```

Steps in order of the mini pipeline

1. Build the Spring Boot JAR:

   ```bash
   mvn clean package
   ```
2. Build the Docker image:

   ```bash
   docker build -t springbootfinal:local .
   ```
3. Start Minikube (if not already running):

   ```bash
   minikube start
   ```
4. Apply PV and PVC:

   ```bash
   kubectl apply -f k8s-pv.yaml
   ```
5. Apply Deployment and Service:

   ```bash
   kubectl apply -f k8s-webapp.yaml
   ```
6. Verify pods and services:

   ```bash
   kubectl get pods -w
   kubectl get svc
   ```
7. Access the app using Minikube IP and NodePort:

   ```bash
   curl http://<MINIKUBE_IP>:30002/hello
   ```

## Automated Deployment

To deploy everything automatically, run:

```bash
./deploy-all.sh
```

This script successfully:

* Starts Minikube if not running
* Applies PV and PVC
* Applies Deployment and Service
* Waits for pod readiness
* Displays ConfigMaps, Deployments, and Services

## Notes

* The app is exposed via a NodePort (default `30002`) for easy access.
* The persistent volume ensures data is retained across pod restarts.
* The project follows the recommended DevOps pipeline for deploying Spring Boot apps to Kubernetes.
