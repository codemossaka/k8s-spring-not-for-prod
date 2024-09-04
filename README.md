
# Spring Boot REST API with PostgreSQL and Helm Deployment

This project is a simple Spring Boot REST API integrated with a PostgreSQL database, deployed using **Helm** and **Kubernetes**. It includes all necessary Kubernetes resources like ConfigMaps, Secrets, StatefulSets, and PersistentVolumeClaims (PVC) to manage the application and database.

## Prerequisites

1. **Minikube** installed and running on your local machine.
2. **kubectl** installed to interact with your Minikube cluster.
3. **Helm** installed for managing Kubernetes packages.

### Install Minikube and Start the Cluster

If Minikube is not installed, follow these instructions to set it up:

- [Install Minikube](https://minikube.sigs.k8s.io/docs/start/)

Once Minikube is installed, start the cluster:

```bash
minikube start
```

Check if your cluster is running:

```bash
minikube status
```

### Install Helm (if not installed)

To install **Helm**, you can run:

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

Verify the installation:

```bash
helm version
```

## Deploying the Application on Minikube

### 1. Clone or Download the Project

First, clone or download this project and navigate to the project folder.

```bash
# Example: Downloading the project and navigating into the directory
unzip spring-boot-rest-api-final-corrected.zip
cd spring-boot-rest-api
```

### 2. Initialize Helm on Minikube (if not already done)

To initialize Helm and create necessary namespaces (if required), you can run:

```bash
helm repo add stable https://charts.helm.sh/stable
helm repo update
```

### 3. Deploy the Application

The project contains pre-configured Helm charts for both **development** and **production** environments.

- **For Development**:

```bash
helm install my-backend-api ./charts -f charts/env/dev/values.yaml
```

- **For Production**:

```bash
helm install my-backend-api ./charts -f charts/env/prod/values.yaml
```

### 4. Verify the Deployment

You can verify that the pods are running with the following command:

```bash
kubectl get pods
```

You should see pods for both the **backend** (Spring Boot) and **PostgreSQL** services.

Also, check the services:

```bash
kubectl get svc
```

This will show the services running inside the Minikube cluster.

### 5. Accessing the Application

By default, the application will be exposed within the cluster. To access it locally, you can use **Minikube tunneling** to expose the service:

```bash
minikube tunnel
```

Then, you can access the application using Minikube’s IP address. First, get the IP address and port:

```bash
minikube service list
```

You should now be able to access the Spring Boot application by navigating to `http://<minikube-ip>:<port>/api/hello` in your browser or using `curl`:

```bash
curl http://<minikube-ip>:<port>/api/hello
```

This should return the "Hello, World!" message.

### 6. Scaling the Application

To scale the application (e.g., increase the number of replicas), use the following command:

```bash
kubectl scale deployment my-backend-api --replicas=3
```

You can adjust the number of replicas as needed for your deployment.

### 7. Uninstalling the Application

To uninstall the application and delete all related Kubernetes resources:

```bash
helm uninstall my-backend-api
```

This will remove the deployment, StatefulSets, ConfigMaps, Secrets, PVCs, and other resources.

### Troubleshooting

- **Check logs**: If something isn't working as expected, check the logs of your pods to diagnose the issue.

```bash
kubectl logs <pod-name>
```

- **Get detailed pod info**: Use the following command to get detailed information on any problematic pod.

```bash
kubectl describe pod <pod-name>
```

## Conclusion

You have successfully deployed a Spring Boot REST API with PostgreSQL on **Minikube** using Helm! This setup is easily adaptable to other Kubernetes environments (GKE, EKS, etc.) by adjusting the `values.yaml` file.
