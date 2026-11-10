# Introduction to Kubernetes

*A beginner-friendly lesson for DevOps, SRE, and production support*

## Learning Objectives

By the end of this lesson, learners should be able to:

- Explain what Kubernetes is.
- Describe why organizations use Kubernetes.
- Understand common Kubernetes terminology.
- Deploy and inspect a Pod.
- Understand Deployments and Services.
- Use basic `kubectl` commands.
- Troubleshoot common beginner issues.

## 1. What Is Kubernetes?

Kubernetes (K8s) is an open-source container orchestration platform created by Google and now maintained by the Cloud Native Computing Foundation (CNCF).

> Think of Kubernetes as an operating system for containers.

Just as Windows or Linux manages processes on a computer, Kubernetes manages containers across many servers.

Without Kubernetes:

```text
Server
 ├── App Container
 ├── Database Container
 └── Monitoring Container
```

If a container crashes, you fix it manually.

With Kubernetes:

```text
Kubernetes Cluster
 ├── Pod A
 ├── Pod B
 ├── Pod C
 └── Monitoring
```

If a container crashes, Kubernetes can restart it automatically.

## 2. Why Do Companies Use Kubernetes?

Organizations like Netflix, Spotify, Airbnb, Adobe, and Morgan Stanley use Kubernetes because it provides:

| Feature | Benefit |
|---|---|
| Self-healing | Restarts failed containers |
| Scalability | Adds instances automatically |
| Load balancing | Distributes traffic |
| High availability | Reduces downtime |
| Rolling updates | Deploys without outages |
| Resource management | Controls CPU and memory usage |

## 3. Kubernetes vs. Docker

Many beginners confuse these tools.

### Docker

Docker creates and runs containers:

```bash
docker run nginx
```

### Kubernetes

Kubernetes manages containers at scale:

```bash
kubectl apply -f nginx-deployment.yaml
```

In short:

- **Docker** = container engine
- **Kubernetes** = container manager

## 4. Key Kubernetes Terminology

### Cluster

A collection of machines running Kubernetes:

```text
Cluster
 ├── Control Plane
 ├── Worker Node 1
 └── Worker Node 2
```

### Node

A machine in the cluster. A node can be a:

- Physical server
- Virtual machine
- Cloud instance

Example:

```text
Node 1
 ├── Pod A
 └── Pod B
```

### Pod

The smallest deployable object in Kubernetes. A Pod usually contains one or more containers:

```text
Pod
 └── Container
```

Or:

```text
Pod
 ├── App Container
 └── Logging Container
```

**Interview question:** What is the smallest deployable unit in Kubernetes?

**Answer:** A Pod.

### Container

An application running inside a Pod:

```text
Pod
 └── nginx container
```

### Deployment

A Deployment manages Pods. For example:

```yaml
replicas: 3
```

Kubernetes ensures three Pods are running. If one dies, Kubernetes creates another:

```text
Current: 2 Pods
Kubernetes creates another Pod
```

### ReplicaSet

A ReplicaSet maintains the desired number of Pods. It is usually managed automatically by a Deployment.

### Service

A Service provides a stable network endpoint. Pod IP addresses can change, but applications can use the Service name:

```text
service-name
```

This gives applications a stable way to find each other.

## 5. Understanding YAML Files

Most Kubernetes resources are defined using YAML.

Example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hello-pod
spec:
  containers:
    - name: nginx
      image: nginx
```

### Key Sections

#### `apiVersion`

Specifies which Kubernetes API to use:

```yaml
apiVersion: v1
```

#### `kind`

Specifies the resource type. Examples:

```yaml
kind: Deployment
kind: Service
kind: ConfigMap
kind: Secret
```

#### `metadata`

Provides information about the object:

```yaml
metadata:
  name: hello-pod
```

#### `spec`

Defines the desired configuration:

```yaml
spec:
  containers:
```

## 6. Your First Pod

Create a file named `hello-pod.yaml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hello-pod
spec:
  containers:
    - name: nginx
      image: nginx
```

Deploy it:

```bash
kubectl apply -f hello-pod.yaml
```

Verify:

```bash
kubectl get pods
```

Expected output:

```text
NAME        READY   STATUS
hello-pod   1/1     Running
```

## 7. Labels

Labels help organize resources.

Example:

```yaml
metadata:
  labels:
    app: web
    environment: dev
```

Find Pods by label:

```bash
kubectl get pods -l app=web
```

Show labels:

```bash
kubectl get pods --show-labels
```

## 8. Most Important `kubectl` Commands

### View Pods

```bash
kubectl get pods
```

### Get Detailed Information

```bash
kubectl describe pod hello-pod
```

### View Logs

```bash
kubectl logs hello-pod
```

### Execute a Command Inside a Pod

```bash
kubectl exec -it hello-pod -- bash
```

### Delete a Pod

```bash
kubectl delete pod hello-pod
```

### Apply Changes

```bash
kubectl apply -f hello-pod.yaml
```

## 9. Deployments

Pods are temporary, so production systems typically use Deployments to manage them.

Example Deployment:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: nginx
          image: nginx
```

Deploy:

```bash
kubectl apply -f deployment.yaml
```

Check:

```bash
kubectl get deployments
```

## 10. Services

Services expose applications to other workloads or users.

Example:

```yaml
kind: Service
```

Common Service types:

| Type | Usage |
|---|---|
| `ClusterIP` | Internal cluster traffic |
| `NodePort` | Exposes a port on each node |
| `LoadBalancer` | Requests a cloud load balancer |

## Common Interview Questions

### What happens when a Pod crashes?

Kubernetes automatically recreates it if it is managed by a Deployment.

### Why use a Deployment instead of a Pod?

Deployments provide:

- Scaling
- Rollbacks
- Self-healing
- Updates

### What is the difference between a Pod and a Container?

- **Container:** The application process.
- **Pod:** A wrapper around one or more containers.

### What is a Service?

A stable endpoint used to access Pods.

## Kubernetes Troubleshooting Tips

### Pod Not Starting

Check the Pod status:

```bash
kubectl get pods
```

Then inspect the Pod:

```bash
kubectl describe pod hello-pod
```

Look for states such as:

- `ImagePullBackOff`
- `ErrImagePull`
- `CrashLoopBackOff`

### Application Crashing

Check the application logs:

```bash
kubectl logs <pod-name>
```

### Pod Stuck Pending

Common reasons include:

- Not enough CPU
- Not enough memory
- Node unavailable

Check the Pod details and events:

```bash
kubectl describe pod <pod-name>
```

### Pod Keeps Restarting

Check Pod status and restart counts:

```bash
kubectl get pods
```

Then inspect the logs:

```bash
kubectl logs <pod-name>
```

## Kubernetes Cheat Sheet

```bash
kubectl get pods
kubectl get deployments
kubectl apply -f app.yaml
kubectl describe pod mypod
kubectl logs mypod
kubectl exec -it mypod -- bash
kubectl delete pod mypod
kubectl get services
kubectl get pods -l app=web
```

## Memory Trick for Beginners

Think of Kubernetes like a restaurant:

| Kubernetes | Restaurant |
|---|---|
| Cluster | Restaurant |
| Node | Kitchen |
| Pod | Plate |
| Container | Food |
| Deployment | Recipe |
| Service | Waiter |
| ReplicaSet | Keeps enough plates available |

- If a plate drops, the ReplicaSet creates a new plate.
- If more customers arrive, the Deployment increases the replicas.
- If customers need food, the Service directs them to available Pods.

This analogy helps many beginners quickly understand how Kubernetes components work together.
