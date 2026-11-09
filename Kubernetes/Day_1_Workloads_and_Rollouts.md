# Day 1: Workloads and Rollouts

**Duration:** 5 hours  
**Goal:** Understand the Kubernetes object model and deploy, scale, inspect, update, and roll back an application.

## Learning Objectives

By the end of this lesson, you can:

- Describe the control plane and worker-node responsibilities.
- Inspect resources and diagnose basic Pod state with `kubectl`.
- Explain why application Pods are normally managed by Deployments.
- Scale a Deployment and verify self-healing.
- Observe a rolling update and recover from a failed rollout.

## Hour 1: Architecture and `kubectl` Fluency

Kubernetes stores the desired state of a cluster in its API. The control plane makes scheduling and reconciliation decisions; node components run assigned workloads.

| Component | Responsibility |
|---|---|
| API server | Validates and exposes the Kubernetes API |
| etcd | Stores cluster state |
| Scheduler | Selects a node for an unscheduled Pod |
| Controllers | Reconcile actual state toward desired state |
| Kubelet | Runs and monitors Pods assigned to a node |
| Container runtime | Starts and manages containers |

On a single-node k3s lab, control-plane and workload roles share the same host.

```bash
kubectl cluster-info
kubectl get nodes -o wide
kubectl get pods -A
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl explain deployment.spec
```

For any unfamiliar resource, use this diagnostic sequence:

```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl logs <pod-name> --previous
kubectl exec -it <pod-name> -- sh
```

`--previous` is useful after a container restarts. Add `-n <namespace>` when the resource is outside the current namespace. Configure shell completion and a `k` alias only if your shell supports them; these are convenience features, not required for the labs.

### Exercise 1A — Cluster orientation

1. List nodes, namespaces, and Pods in all namespaces.
2. Select one system Pod and inspect its labels, events, and logs.
3. Use `kubectl explain pod.spec.containers` to find where a container image is specified.

**Check:** You can identify the namespace and node for a Pod and explain one recent event.

## Hour 2: Pods and Declarative YAML

A Pod is the smallest schedulable Kubernetes unit. It can contain one or more tightly coupled containers that share networking and may share volumes. Pods are replaceable; their IPs and names are not stable identities.

Create `hello-pod.yaml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hello
  labels:
    app: hello
spec:
  containers:
    - name: web
      image: nginx:1.27
      ports:
        - name: http
          containerPort: 80
```

Apply and inspect it:

```bash
kubectl apply -f hello-pod.yaml
kubectl get pod hello -o wide
kubectl describe pod hello
kubectl exec -it hello -- sh
kubectl delete -f hello-pod.yaml
```

This bare Pod is for learning. A Deployment is normally preferred for an application because it maintains the requested number of replaceable Pods.

### Exercise 2A — Change the manifest

Add a label of your choice, apply the change, then use a label selector to find the Pod. Delete it after inspecting the result.

**Check:** `kubectl get pods --show-labels` shows your label.

## Hour 3: Deployments and ReplicaSets

A Deployment manages ReplicaSets, which maintain the desired number of matching Pods. If a managed Pod disappears, the controllers create a replacement.

```bash
kubectl create deployment web --image=nginx:1.27
kubectl get deployment,replicaset,pods
kubectl scale deployment/web --replicas=4
kubectl get pods -l app=web -o wide
```

Delete one Pod selected from the preceding output:

```bash
kubectl delete pod <one-web-pod>
kubectl get pods -l app=web -w
```

Stop watching with Ctrl+C. Inspect the replacement and its owning ReplicaSet.

### Exercise 3A — Declarative Deployment

Generate a starter file without applying it:

```bash
kubectl create deployment web --image=nginx:1.27 --dry-run=client -o yaml > web-deployment.yaml
```

Review the file, apply it, and scale to four replicas using either the manifest or `kubectl scale`.

**Check:** Four Ready Pods are selected by `app=web`. A deleted Pod is replaced.

## Hour 4: Rolling Updates and Rollbacks

Change the image using the API:

```bash
kubectl set image deployment/web nginx=nginx:1.28
kubectl rollout status deployment/web
kubectl rollout history deployment/web
```

Try a deliberately invalid image tag in this lab Deployment:

```bash
kubectl set image deployment/web nginx=nginx:not-a-real-tag
kubectl rollout status deployment/web --timeout=90s
kubectl get pods
kubectl describe pod <new-pod-name>
```

Observe the image-pull error. Restore the last working revision:

```bash
kubectl rollout undo deployment/web
kubectl rollout status deployment/web
```

Do not use the broken image on a shared or production workload. A failed rollout may leave some old Pods serving while new Pods fail to start.

### Exercise 4A — Rollout evidence

Record the image, available replica count, and relevant event before and after the rollback.

**Check:** The Deployment is available again and its Pods use the working image.

## Hour 5: Day 1 Lab Challenge

Deploy an NGINX application declaratively, scale to four replicas, replace one Pod, and perform one working image update followed by a rollback.

### Tasks

1. Keep the final Deployment manifest in your lab directory.
2. Capture output from `kubectl get deployment,replicaset,pods`.
3. Run `kubectl describe deployment web` and identify the rollout-related events.
4. Explain the relationship between the Deployment, ReplicaSet, and Pods in your own words.

### Completion Criteria

- Four Pods are Ready and share the expected application label.
- Deleting one managed Pod causes a replacement.
- Rollout history is visible, and the final image is a known working version.
- You can identify the relevant ReplicaSet and events.

### Cleanup

```bash
kubectl delete deployment web
kubectl delete pod hello --ignore-not-found
```

Remove only the files and resources created for this lesson.
