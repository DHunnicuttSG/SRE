# Day 4: Troubleshooting and Observability

**Duration:** 5 hours  
**Goal:** Diagnose common Kubernetes failures, verify service routing, explore metrics, and complete a bounded multi-tier support drill.

## Learning Objectives

By the end of this lesson, you can:

- Gather evidence for common Pod and container failures.
- Trace a Service from selector to endpoints and target port.
- Install and inspect a monitoring chart in a dedicated namespace.
- Use logs, events, resource metrics, and rollout history in an incident workflow.
- Clean up only the resources created for a lab.

## Hour 1: Diagnose Pod Failures

Start with state and events, then inspect the affected resource and logs:

```bash
kubectl get pods -o wide
kubectl describe pod <pod-name>
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl logs <pod-name>
kubectl logs <pod-name> --previous
```

| Symptom | Evidence to collect | Typical direction |
|---|---|---|
| `ImagePullBackOff` | Pod Events, image name/tag, registry access | Correct image reference or registry credentials |
| `CrashLoopBackOff` | Current and previous logs, exit code, command, configuration | Fix startup error or missing dependency |
| `Pending` | Pod Events, node capacity, PVC status, node selectors | Resolve scheduling constraints or storage binding |
| `OOMKilled` | Container last state, memory limits, node pressure, application logs | Investigate memory use and tune limits based on evidence |

### Exercise 1A — Four failure observations

In a disposable namespace, create four separate examples:

1. An image with an invalid tag.
2. A container command that exits immediately.
3. A Pod requesting more resources than the lab node can provide, or a Pod waiting on an intentionally unmatched PVC.
4. A small memory-limited container that allocates beyond its limit.

For each, record the symptom, the useful `describe`/Events output, a likely cause, and a safe correction. Do not apply resource-exhaustion tests to a shared host. If the EC2 instance is resource-constrained, use the pending-PVC variant instead of stressing node memory.

**Check:** You can distinguish image retrieval, process exit, scheduling/storage, and memory termination from Events and container state.

## Hour 2: Debug Broken Service Networking

For a Service that returns a timeout or gateway error, follow the path in order:

1. Is the client using the expected Service name and port?
2. Does the Service selector match Pod labels?
3. Are there ready endpoints?
4. Does `targetPort` match the application listener?
5. Can a Pod reach the target application port?
6. Are NetworkPolicies or application-level proxies involved?

```bash
kubectl get service <service-name> -o yaml
kubectl get pods --show-labels
kubectl get endpoints <service-name>
kubectl get endpointslices -l kubernetes.io/service-name=<service-name>
kubectl describe service <service-name>
```

Kubernetes Services do not themselves generate HTTP 502 responses; a proxy or gateway may return one when its upstream is unavailable. Use the caller, proxy, and backend logs to locate which hop reports the error.

### Exercise 2A — Selector mismatch

1. Deploy NGINX and expose it with a ClusterIP Service.
2. Confirm that the Service has an endpoint and test with port-forward.
3. Change the Service selector so it matches no Pod.
4. Observe the empty endpoints and failed request.
5. Restore the selector and verify the request succeeds.

**Check:** You can explain the relationship between the selector, endpoints, and target port.

## Hour 3: Observability with Prometheus and Grafana

The `kube-prometheus-stack` chart deploys several components and can consume significant CPU, memory, and disk. Check the EC2 instance's capacity first; use a larger temporary lab host if necessary. Do not expose Grafana publicly for this exercise.

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm show values prometheus-community/kube-prometheus-stack
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring --create-namespace
kubectl get pods -n monitoring
helm status monitoring -n monitoring
```

Wait for the Pods to become ready. Find the Grafana Service and forward its port only to the EC2 host's loopback interface:

```bash
kubectl get services -n monitoring
kubectl port-forward -n monitoring service/<grafana-service-name> 3000:80
```

If you are browsing from your laptop, create an SSH tunnel from the laptop to the EC2 host's loopback port, then browse to `http://127.0.0.1:3000`. Do not add a public inbound rule for Grafana. Follow the chart's current documentation for initial access credentials and treat them as secrets; do not paste them into notes, manifests, or shell history.

Explore a cluster overview and a Pod health dashboard. Compare observed CPU/memory data with `kubectl get pods` and recent Events.

### Exercise 3A — Correlate signals

Select one Pod and record its status, recent Events, and available metrics. Describe one conclusion supported by the evidence and one question the available data cannot answer.

**Check:** You can distinguish resource metrics from application logs and Kubernetes Events.

## Hour 4: Capstone — Broken Multi-Tier Lab

Build or reuse a small web frontend, API, and PostgreSQL setup in a dedicated `capstone` namespace. Use a Secret for the database password, a PVC for database files, internal Services for API and database access, and readiness/liveness probes only when supported by the applications.

### Drill

1. Record the initial state of Deployments, Pods, Services, PVCs, and recent Events.
2. Intentionally introduce one reversible fault at a time: an invalid image tag, a mismatched Service selector, or an incorrect non-secret configuration value.
3. Follow the evidence from frontend to API to database using Service endpoints, `describe`, and logs.
4. Correct the fault and verify the rollout and application path.
5. If metrics are available, compare `kubectl top nodes` and `kubectl top pods` with observed behavior. These commands require a functioning metrics provider.
6. Demonstrate a Deployment rollback after a controlled image update.

### Completion Criteria

- Each tier has a clear Deployment and Service role.
- Database credentials are referenced from a Secret and are not included in source files or logs.
- The PVC remains bound after database Pod replacement.
- You can identify and fix one workload failure and one networking failure.
- You verify recovery using readiness, endpoints, logs, or rollout status—not only a `Running` Pod state.

## Hour 5: Wrap-Up and Portfolio

Review your notes and manifests. Keep a clean copy of the manifests and a short README explaining prerequisites, how to deploy, how to verify, and how to clean up. Remove secrets and environment-specific values before committing to GitHub.

### Final Review Checklist

- Can you explain why a Deployment replaces Pods and why Pod IPs are not stable?
- Can you identify the difference between ClusterIP and NodePort?
- Can you trace a Service selector to its endpoints and target port?
- Can you explain what a PVC does—and what local-path storage does not guarantee?
- Can you distinguish a readiness failure from a liveness restart?
- Can you find the relevant Events, current logs, and previous container logs?
- Can you verify and roll back a Deployment update?
- Did you remove temporary public Security Group rules and test workloads?

### Safe Cleanup

Inspect namespaces before deleting anything:

```bash
kubectl get namespaces
kubectl get all,pvc -n capstone
```

After confirming all resources in the namespace belong to this lab and any data is disposable:

```bash
kubectl delete namespace capstone
helm uninstall monitoring --namespace monitoring
kubectl delete namespace monitoring
```

Do not delete `kube-system`, the EC2 instance, or resources outside the dedicated lab namespaces. If you installed other resources, inspect and remove only those that you created.
