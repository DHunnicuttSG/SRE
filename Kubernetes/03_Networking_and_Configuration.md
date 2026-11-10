# Day 2: Networking and Configuration

**Duration:** 5 hours  
**Goal:** Give workloads stable network access, configure them without rebuilding images, and apply basic namespace and resource boundaries.

## Learning Objectives

By the end of this lesson, you can:

- Explain how Services provide stable access to replaceable Pods.
- Distinguish ClusterIP and NodePort Services.
- Configure workloads with ConfigMaps and Secrets.
- Use namespaces and set resource requests and limits.
- Diagnose a Service that has no endpoints.

## Hour 1: Pod Networking and Services

Pods receive cluster IPs, but Pods can be replaced and their IPs change. A Service selects Pods by labels and provides a stable virtual IP and DNS name.

- **ClusterIP** is reachable inside the cluster and is the normal default.
- **NodePort** exposes a port on each node for testing. It is not a secure ingress solution and does not provide application authentication or TLS.

A Service selector must match the target Pods' labels, and its `targetPort` must match the port the application actually listens on.

```bash
kubectl get services
kubectl get endpoints
kubectl get endpointslices
kubectl describe service <service-name>
```

### Exercise 1A — Find a Service's targets

Create an NGINX Deployment, then inspect its labels and compare them with the selector and endpoints of the Service you create in Hour 2.

**Check:** The Service has endpoints corresponding to Ready Pods.

## Hour 2: Expose an Application for Testing

Create a ClusterIP Service first:

```bash
kubectl create deployment web --image=nginx:1.27
kubectl expose deployment web --name=web --port=80 --target-port=80
kubectl get service web
kubectl get endpoints web
```

Test from the EC2 host without opening an inbound port:

```bash
kubectl port-forward service/web 8080:80
```

In another EC2 shell, request `http://127.0.0.1:8080`. Stop port-forwarding with Ctrl+C.

If practicing NodePort, create a temporary Service in the same namespace as the `web` Deployment (the commands above use your current namespace):

```bash
kubectl expose deployment web --name=web-nodeport --type=NodePort --port=80 --target-port=80
kubectl get service web-nodeport
```

Use the assigned `nodePort`. A direct browser test requires a temporary EC2 Security Group rule restricted to your current public IP. Remove the rule and delete the NodePort Service immediately after the test. Prefer an SSH tunnel or port-forward for normal work; never open the whole NodePort range to `0.0.0.0/0`.

### Exercise 2A — Compare exposure methods

Write down which address is reachable from inside the cluster and which port is exposed on the node. Delete the temporary NodePort Service after the comparison.

**Check:** The ClusterIP Service remains internal; the NodePort is removed.

## Hour 3: ConfigMaps and Secrets

ConfigMaps hold non-sensitive configuration. Secret data is base64-encoded in the Kubernetes API representation, which is not encryption; a manifest using `stringData` can contain plaintext. Restrict access with RBAC and avoid committing credentials or kubeconfig files to source control.

Create a ConfigMap:

```bash
kubectl create configmap web-settings --from-literal=APP_MODE=training
```

For a disposable lab, create a protected temporary file and remove it after creating the Secret. Use only a throwaway password:

```bash
umask 077
read -s -p "Disposable lab password: " DB_PASSWORD
printf '\n'
printf '%s' "$DB_PASSWORD" > db-password
unset DB_PASSWORD
kubectl create secret generic db-auth --from-file=password=db-password
rm -f -- db-password
```

Reference configuration from a Pod template:

```yaml
env:
  - name: APP_MODE
    valueFrom:
      configMapKeyRef:
        name: web-settings
        key: APP_MODE
  - name: DB_PASSWORD
    valueFrom:
      secretKeyRef:
        name: db-auth
        key: password
```

Apply these entries to a Deployment's container and verify the non-sensitive setting with `kubectl exec`. Do not print the password to the terminal or include it in diagnostic output.

To practice mounted configuration, create a ConfigMap from a local file:

```bash
kubectl create configmap site-content --from-file=index.html
```

Mount it as a volume in an NGINX Pod template. ConfigMap volume updates may take time to appear; environment-variable values require a Pod restart to refresh.

### Exercise 3A — Configuration review

1. Configure a Pod using the ConfigMap value.
2. Reference the Secret without printing it.
3. Inspect the workload specification and identify which field refers to each object.
4. Confirm no credential was written into a manifest.

**Check:** The Pod starts, reads the expected non-sensitive setting, and keeps the secret value out of logs and source files.

## Hour 4: Namespaces and Resource Controls

Namespaces scope names and provide a place to apply access policies and quotas. They are not, by themselves, a security boundary.

```bash
kubectl create namespace training
kubectl -n training create deployment web --image=nginx:1.27
kubectl -n training get all
```

A container can declare resource requests (used for scheduling) and limits (enforced ceilings):

```yaml
resources:
  requests:
    cpu: 100m
    memory: 64Mi
  limits:
    cpu: 500m
    memory: 128Mi
```

Create a quota in the training namespace:

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: training-quota
  namespace: training
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 512Mi
    limits.cpu: "2"
    limits.memory: 1Gi
    pods: "10"
```

Apply it and inspect usage:

```bash
kubectl apply -f training-quota.yaml
kubectl -n training describe resourcequota training-quota
```

### Exercise 4A — Observe admission limits

Apply requests and limits to the Deployment. Create additional test Pods only until you observe how the quota affects admission, then delete the test Pods.

**Check:** You can distinguish a scheduling issue from a quota rejection by inspecting `kubectl describe` and Events.

## Hour 5: Day 2 Lab Challenge

Create a custom NGINX welcome page with a ConfigMap and serve it through a Service.

### Tasks

1. Use the `training` namespace created in Hour 4 (recreate it only if you already cleaned it up).
2. Create `index.html` with a custom welcome message.
3. Create a ConfigMap from the file and mount it at the NGINX document root in a Deployment.
4. Create a ClusterIP Service and confirm the page with `kubectl port-forward`.
5. Optionally expose a temporary NodePort only if needed; restrict its Security Group source to your IP and remove the rule afterward.

Use this Pod-template fragment for the ConfigMap mount:

```yaml
containers:
  - name: nginx
    image: nginx:1.27
    ports:
      - name: http
        containerPort: 80
    volumeMounts:
      - name: site-content
        mountPath: /usr/share/nginx/html
volumes:
  - name: site-content
    configMap:
      name: site-content
```

### Completion Criteria

- The Deployment has a Ready Pod.
- The Service has at least one endpoint.
- The page returned through port-forward contains your custom message.
- No public rule remains open for the exercise.

### Cleanup

```bash
kubectl delete namespace training
kubectl delete deployment web --ignore-not-found
kubectl delete service web --ignore-not-found
kubectl delete service web-nodeport --ignore-not-found
kubectl delete configmap web-settings site-content --ignore-not-found
kubectl delete secret db-auth --ignore-not-found
```

Delete only the named lab objects. If you used another namespace, update the cleanup command to target that namespace rather than deleting unrelated resources.
