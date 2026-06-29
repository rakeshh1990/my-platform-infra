# 🚀 My Platform Infrastructure

> Kubernetes platform bootstrap repository for the Stock Alert ecosystem.

---

# Overview

This repository contains the infrastructure required to provision and bootstrap the Kubernetes platform used by the Stock Alert application.

Unlike the application repository, this project focuses entirely on platform components required to run workloads in Kubernetes.

The platform is designed to closely resemble a production Kubernetes environment while remaining lightweight enough for local development using Minikube.

---

# Responsibilities

This repository is responsible for deploying and managing the core platform components including:

* Kubernetes cluster bootstrap
* Ingress Controller
* ArgoCD
* PostgreSQL
* Redpanda (Kafka compatible)
* Namespaces
* Shared infrastructure
* Helm releases

Application workloads are **not** managed here. They are deployed separately through the GitOps repository.

---

# Platform Architecture

```text
                    Kubernetes Cluster

                           │
      ┌────────────────────┴────────────────────┐
      │                                         │
      ▼                                         ▼

Ingress Controller                       ArgoCD

      │                                         │

      ▼                                         ▼

 PostgreSQL                              GitOps Repository

      │

      ▼

 Redpanda

      │

      ▼

 Application Workloads
```

---

# Repository Structure

```text
my-platform-infra/

├── terraform/
│
├── helm/
│
├── bootstrap/
│
├── scripts/
│
└── README.md
```

---

# Platform Components

## Kubernetes

The platform is deployed on Kubernetes and follows standard cloud-native deployment practices.

Responsibilities include

* Service discovery
* Scheduling
* Scaling
* Health checks
* Rolling updates

---

## Ingress Controller

The platform uses NGINX Ingress Controller to expose HTTP services.

Responsibilities

* Host based routing
* Reverse proxy
* TLS ready
* Centralized entry point

---

## PostgreSQL

Shared PostgreSQL instance used by multiple microservices.

Each service owns an independent database while sharing the same PostgreSQL server.

Examples

* authdb
* userdb
* scannerdb

---

## Redpanda

Redpanda provides Kafka-compatible messaging.

Responsibilities

* Event streaming
* Alert events
* Notification events
* Future asynchronous workflows

---

## ArgoCD

ArgoCD continuously monitors the GitOps repository and synchronizes Kubernetes resources automatically.

Deployment model

```text
Git Commit

      │

      ▼

GitOps Repository

      │

      ▼

ArgoCD

      │

      ▼

Kubernetes
```

---

# Infrastructure as Code

Infrastructure is managed declaratively using:

* Terraform
* Helm
* Kubernetes manifests

The objective is to minimize manual cluster administration.

---

# Local Development

The platform is designed for local development using:

* Docker Desktop
* Minikube
* Helm
* kubectl
* Terraform

This enables a production-like development environment on a single machine.

---

# Deployment Order

Typical platform bootstrap sequence

1. Start Kubernetes cluster
2. Install Ingress Controller
3. Deploy PostgreSQL
4. Deploy Redpanda
5. Install ArgoCD
6. Connect ArgoCD to GitOps repository
7. Synchronize application workloads

---

# Design Principles

The platform follows several engineering principles.

## Infrastructure as Code

All infrastructure is version controlled.

---

## GitOps

Application deployments originate from Git rather than manual kubectl commands.

---

## Reproducibility

The platform can be recreated from source with minimal manual intervention.

---

## Separation of Concerns

Infrastructure and application code are maintained in separate repositories.

---

## Cloud Native

Platform components are containerized and deployed using Kubernetes-native resources.

---

# Related Repositories

| Repository        | Purpose                      |
| ----------------- | ---------------------------- |
| stock-alert       | Application source code      |
| my-gitops         | GitOps deployment repository |
| my-platform-infra | Platform infrastructure      |

---

# Current Components

## Infrastructure

* Kubernetes
* Docker
* Minikube

## Networking

* NGINX Ingress

## Data

* PostgreSQL

## Messaging

* Redpanda

## Deployment

* ArgoCD

## Packaging

* Helm

## Infrastructure

* Terraform

---

# Roadmap

The platform will continue evolving with production-grade capabilities.

Planned enhancements include

* Prometheus
* Grafana
* Loki
* Tempo
* OpenTelemetry Collector
* External Secrets
* Cert Manager
* Horizontal Pod Autoscaler
* Vertical Pod Autoscaler
* Network Policies
* RBAC hardening
* Pod Disruption Budgets
* Multi-environment support
* Automated backups
* Persistent monitoring stack

---

# Project Status

Current Status

✅ Kubernetes platform bootstrapped

✅ Infrastructure as Code

✅ GitOps enabled

✅ Shared platform services deployed

🚧 Observability platform under development

---

# Author

**Rakesh H**

Platform Engineer | DevOps | Kubernetes | Cloud | Observability

This repository contains the platform infrastructure powering the Stock Alert ecosystem and serves as a hands-on implementation of modern Platform Engineering practices.
