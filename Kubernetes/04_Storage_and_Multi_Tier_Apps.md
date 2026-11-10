# Day 3: Storage and Multi-Tier Applications

**Duration:** 5 hours  
**Goal:** Persist database files across Pod replacement, use health probes, connect application tiers, and install a Helm chart.

## Learning Objectives

By the end of this lesson, you can:

- Explain the relationship between PersistentVolumes, PersistentVolumeClaims, and Pods.
- Deploy a lab database using a PVC and verify data after Pod replacement.
- Configure readiness and liveness probes.
- Connect services using Kubernetes DNS and a Secret reference.
- Inspect and manage a chart installation with Helm.

## Hour 1: Persistent Storage

Containers and Pods are replaceable, so data written only to a container's writable layer is not durable across Pod replacement. A PersistentVolumeClaim (PVC) requests storage; a provisioner may create a PersistentVolume (PV) to satisfy it.

```bash
kubectl get storageclass
kubectl get pv,pvc -A
```

k3s normally installs a `local-path` StorageClass. It is convenient for a single-node lab, but its data is on the node's local disk. It is not replicated, highly available, or a backup. A production database needs an intentional storage, backup, access-control, and recovery design.

### Exercise 1A — PVC lifecycle

Save as `storage-check.yaml`:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: storage-check
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: storage-check
spec:
  containers:
    - name: writer
      image: busybox:1.36
      command: ["sh", "-c", "echo persistent > /data/check.txt; sleep 3600"]
      volumeMounts:
        - name: data
          mountPath: /data
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: storage-check
```

Apply and inspect the claim and mounted file:

```bash
kubectl apply -f storage-check.yaml
kubectl get pod,pvc
kubectl describe pvc storage-check
kubectl exec storage-check -- cat /data/check.txt
kubectl delete -f storage-check.yaml
```

Record the bound PV name and StorageClass before cleanup. Deleting the PVC can delete the lab's provisioned storage; use only disposable data.

**Check:** The PVC becomes `Bound`, and the Pod can write a file to the mounted path.

## Hour 2: PostgreSQL with a PVC

Create a namespace and a disposable lab password:

```bash
kubectl create namespace database-lab
umask 077
read -s -p "Disposable PostgreSQL lab password: " POSTGRES_PASSWORD
printf '\n'
printf '%s' "$POSTGRES_PASSWORD" > postgres-password
unset POSTGRES_PASSWORD
kubectl -n database-lab create secret generic postgres-auth --from-file=password=postgres-password
rm -f -- postgres-password
```

Save as `postgres.yaml`:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-data
  namespace: database-lab
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres
  namespace: database-lab
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: postgres:16
          ports:
            - name: postgres
              containerPort: 5432
          env:
            - name: POSTGRES_DB
              value: training
            - name: POSTGRES_USER
              value: learner
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: postgres-auth
                  key: password
          volumeMounts:
            - name: postgres-data
              mountPath: /var/lib/postgresql/data
      volumes:
        - name: postgres-data
          persistentVolumeClaim:
            claimName: postgres-data
```

Apply the manifest and wait:

```bash
kubectl apply -f postgres.yaml
kubectl -n database-lab rollout status deployment/postgres
kubectl -n database-lab get pod,pvc
```

Open `psql` without placing the password in the command line:

```bash
kubectl -n database-lab exec -it deploy/postgres -- psql -U learner -d training
```

At the `psql` prompt:

```sql
CREATE TABLE lab_check (id integer PRIMARY KEY, note text);
INSERT INTO lab_check VALUES (1, 'data survived Pod replacement');
SELECT * FROM lab_check;
\q
```

Delete the Pod, not the PVC, and wait for its replacement:

```bash
kubectl -n database-lab delete pod -l app=postgres
kubectl -n database-lab rollout status deployment/postgres
kubectl -n database-lab exec -it deploy/postgres -- psql -U learner -d training -c 'SELECT * FROM lab_check;'
```

This demonstrates survival of Pod replacement on the same single-node local storage; it does not demonstrate host-failure recovery or backup restoration.

### Exercise 2A — Verify what persisted

Record the Pod name before and after deletion, PVC status, and query result. Explain why deleting the PVC would be a different and potentially destructive operation.

**Check:** The replacement Pod sees the inserted row.

## Hour 3: Readiness and Liveness Probes

- A **readiness probe** controls whether a Pod receives Service traffic. A not-ready Pod may keep running.
- A **liveness probe** detects a container that should be restarted.
- A **startup probe** gives a slow-starting application more time before liveness checks begin.

Inspect the API schema:

```bash
kubectl explain pod.spec.containers.readinessProbe
kubectl explain pod.spec.containers.livenessProbe
```

Example HTTP checks for an application that serves these paths:

```yaml
readinessProbe:
  httpGet:
    path: /ready
    port: http
  periodSeconds: 5
  timeoutSeconds: 2
  failureThreshold: 3
livenessProbe:
  httpGet:
    path: /health
    port: http
  initialDelaySeconds: 10
  periodSeconds: 10
  timeoutSeconds: 2
  failureThreshold: 3
```

Do not copy these paths blindly: the application must actually implement the endpoints. Choose thresholds that allow normal startup and avoid a liveness probe that restarts an app merely because a dependency is temporarily unavailable.

### Exercise 3A — Probe observations

Add appropriate probes to a disposable web Deployment. Make the readiness path fail and observe Pod readiness and Service endpoints; restore the valid path. Avoid creating a liveness loop on a shared workload.

**Check:** An unready Pod is removed from Service endpoints, and a healthy Pod returns after correcting the probe.

## Hour 4: Multi-Tier Application Lab

Within a namespace, a Service can be addressed by its short name. Across namespaces, use `<service>.<namespace>.svc.cluster.local`. For example:

```text
postgres.database-lab.svc.cluster.local
```

Expose PostgreSQL internally:

```bash
kubectl -n database-lab expose deployment postgres --name=postgres --port=5432 --target-port=5432
kubectl -n database-lab get service,endpoints postgres
```

For a backend application, configure its database host as the Service DNS name and reference the password using `secretKeyRef`, as in Day 2. Keep the database Service as ClusterIP; do not expose a database port through NodePort.

### Exercise 4A — Trace a request

Using a backend image available to you, deploy a backend and frontend in a separate `app-lab` namespace. Configure backend DB host, database name, user, and password through environment variables; store only the password in a Secret. Connect from the backend using the database Service's namespace-qualified DNS name.

Inspect:

```bash
kubectl -n app-lab get pods,services,endpoints
kubectl -n app-lab describe pod <backend-pod>
kubectl -n app-lab logs deploy/<backend-deployment>
```

**Check:** The backend resolves the PostgreSQL Service and connects without exposing database credentials in the manifest or logs. If a supplied application image is unavailable, document the required environment variables and validate DNS from a temporary debug Pod instead.

## Hour 5: Helm Basics

Helm packages Kubernetes resources into charts. Inspect chart information and rendered resources before installing when possible.

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo bitnami/nginx
helm show values bitnami/nginx
helm template demo bitnami/nginx
```

Install a chart in a dedicated namespace and inspect its release:

```bash
helm upgrade --install demo bitnami/nginx --namespace helm-lab --create-namespace
helm status demo --namespace helm-lab
helm list --namespace helm-lab
kubectl get all --namespace helm-lab
```

Chart names, values, and defaults can change. Review chart documentation and rendered resources before installation. Do not install charts from untrusted sources into a cluster with sensitive workloads.

### Exercise 5A — Install and remove

1. Render the chart and identify the Deployment and Service it creates.
2. Install it and verify the release.
3. Uninstall it and confirm the chart-managed resources are removed.

**Check:** `helm list -n helm-lab` no longer lists the release after uninstall.

### Cleanup

```bash
helm uninstall demo --namespace helm-lab
kubectl delete namespace helm-lab --ignore-not-found
kubectl delete namespace app-lab --ignore-not-found
kubectl delete namespace database-lab
```

Deleting the database namespace also deletes its PVC and may delete its local PV data. Run this only after recording the lab results and confirming that the data is disposable.
