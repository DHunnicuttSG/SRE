# Kubernetes Crash Course: From First Cluster to Production Support

**Duration:** 4 days, 20 hours (5 hours per day)  
**Audience:** Learners with basic Docker, Linux, and AWS EC2 experience  
**Format:** Four guided lessons with hands-on exercises and troubleshooting labs

## Course Overview

Build on your container and Linux experience to learn how Kubernetes schedules, connects, configures, and monitors applications. The course uses a lightweight, single-node k3s cluster on an EC2 instance so the exercises can run without a desktop virtualization layer.

> **Lab boundary:** A single EC2 instance running k3s is a learning environment, not a production cluster. It has no high availability, and local-path storage is tied to that host. Do not use it for production data or workloads.

## Learning Outcomes

By the end of the course, you will be able to:

- Explain the roles of the Kubernetes control plane, nodes, Pods, Deployments, and Services.
- Apply and inspect declarative manifests; scale, update, and roll back Deployments.
- Expose a workload for testing and configure it with ConfigMaps, Secrets, namespaces, and resource controls.
- Deploy a database with persistent storage and configure health probes.
- Troubleshoot workload, storage, and Service failures using `kubectl`.
- Use Helm to install a chart and inspect cluster metrics.
- Keep lab access restricted and clean up resources safely.

## Before You Start

### Prepare an EC2 lab host

- Use a Linux AMI supported by your AWS account and a disposable instance with enough memory and disk for the exercises. The monitoring stack is resource-intensive; use a larger temporary instance for Day 4 rather than forcing it onto a tiny host.
- Install k3s by following the [official k3s installation guide](https://docs.k3s.io/quick-start). Review the installer and run it only on a host you control. The default installation includes a container runtime and a local-path storage provisioner.
- Install Helm using the [official Helm installation instructions](https://helm.sh/docs/intro/install/).
- Start with only SSH allowed from your current IP in the EC2 Security Group. Do **not** expose the Kubernetes API (TCP 6443) to the internet.
- Prefer `kubectl port-forward` over opening a NodePort. If you need to practice NodePort access, restrict the Security Group source to your current public IP and remove the rule as soon as the exercise ends.
- Use a dedicated lab instance. Back up anything important before installing software or running cleanup exercises.

### Verify the cluster

On the EC2 host, use the k3s-managed `kubectl`:

```bash
sudo k3s kubectl get nodes
sudo k3s kubectl get pods -A
```

The node should report `Ready`. In the lessons, `kubectl` means the command available to your shell. On a k3s host where it is not configured for your user, prefix the examples with `sudo k3s`.

### Lab conventions

- Save manifests in a working directory such as `~/kubernetes-labs`; use one namespace per lab where practical.
- Replace example names and values only where instructed. Never commit real passwords, kubeconfig files, or cloud credentials to Git.
- Read the resource you are about to change before deleting or replacing it. Cleanup commands in this course target only resources created for the lab.
- If an exercise needs a public endpoint, use a temporary, source-restricted rule; a NodePort is not an authentication or encryption layer.

## Schedule

| Lesson | Focus | Duration |
|---|---|---:|
| [Day 1: Workloads and Rollouts](Day_1_Workloads_and_Rollouts.md) | Architecture, `kubectl`, Pods, Deployments, ReplicaSets, updates | 5 hours |
| [Day 2: Networking and Configuration](Day_2_Networking_and_Configuration.md) | Services, NodePort, ConfigMaps, Secrets, namespaces, resource controls | 5 hours |
| [Day 3: Storage and Multi-Tier Apps](Day_3_Storage_and_Multi_Tier_Apps.md) | PVs/PVCs, PostgreSQL, probes, internal DNS, Helm | 5 hours |
| [Day 4: Troubleshooting and Observability](Day_4_Troubleshooting_and_Observability.md) | Failure diagnosis, networking, Prometheus/Grafana, capstone | 5 hours |

## Study Habits

- Generate a starter manifest with `kubectl create deployment web --image=nginx --dry-run=client -o yaml`; review and edit it before applying.
- Use `kubectl explain pod.spec.containers.livenessProbe` to inspect API fields and valid structure.
- After each change, verify the result with `kubectl get`, `kubectl describe`, logs, and rollout status rather than assuming success.
- Keep a short lab journal: what failed, what evidence identified the cause, and how you verified the fix.

## Further Reading

- [Kubernetes Concepts](https://kubernetes.io/docs/concepts/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [k3s Quick-Start Guide](https://docs.k3s.io/quick-start)
- [Helm Documentation](https://helm.sh/docs/)
