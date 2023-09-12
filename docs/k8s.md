
# Presentation of Kubernetes

## Origines

Created by Google in 2015, Kubernetes is an extracted version of Borg, Google's internal container management system. Kubernetes serves as a container orchestrator capable of running Docker containers, among others.

Here are some reasons for using Kubernetes:
- Orchestrating multiple containers, linking them, and more.
- Creating abstractions with services.
- Ensuring durability and automated maintenance.
- Scalability.
- Compatibility with various providers such as Google Cloud, AWS, Azure, and more.

If you have any specific improvements or corrections in mind for this text, please let me know, and I'll be happy to assist you further.

## Notions

**node** is a fundamental component of the cluster and represents an individual worker machine, typically a physical server or a virtual machine, depending on the deployment environment. 

**pods** one or more containers that share the same network, namespace, storage, and other reources.

**service** is an abstraction that defines a set of Pods and a policy for accessing them. Services provide a consistent and reliable way to expose network connectivity to a group of Pods, allowing applications to communicate with one another, both within the cluster and, if configured, from outside the cluster.

**volumes** similar to docker

**deployments** is a resource object used to declare and manage the desired state of a set of identical Pods. Deployments provide a declarative way to define how applications should be deployed, updated, and scaled within a Kubernetes cluster.

**namespace** is a way to create multiple virtual clusters within a single physical cluster. Namespaces are a fundamental concept in Kubernetes and are used to provide scope and isolation for resources within a cluster.

# Minikube

Minikube is a small cluster use mainly to learn the basics of K8s.

## Installation

`brew install minikube; minikube start;`

Now few commands to get informations about minikube.

> kubectl get nodes
Show Kubernetes nodes

> kubectl describe nodes minikube
Show more precise information about the minikube node

