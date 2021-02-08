# Kubernetes
Kubernetes (K8s) is a container orchestration application designed to optimize deployment, scaling and resource utilization.
K8s is Desired State Configuration (DSC) oriented - not action oriented.





# Architecture

## Nodes
A Cluster is composed of two types of nodes:
    - Master node
        - Manages all the Nodes on the cluster
        - one per cluster
    - Worker Nodes
        - host applications in containers

On Cloud services, the master node is not configured but directly provided to you. The worker nodes, on the other hand are alway configurable.
 
Master Node contains:
    - Kube-API Server
        - A front-end for kubernetes
        - Users, CLIs...  interact here
            - User send the `<desired-state-configuration.yaml>` to this API
            - kube-controller-manager will get the configs from this API
    - etcd
        - is a key-value storage
        - Holds the Desired State description
        - locks storage
        - ensures no orchestration concurrency/overlapping/conflicts issues
    - kube-controller-manager
        - constantly checks for DSC changes
        - scheduler-controller
            - gets `<desired-state-configuration.yaml>` from the API
            - gets the available resources and its current status
            - identifies/defines the nodes to deploy - assigns different worknode names to the DSC
            - stores the new state configuration in the `etcs`.
        - node-controller
            - Manages worker Nodes
            - Distributes tasks across nodes
        - replication-controller


Worker nodes contain:
    - Container Runtime
        - Manages the containers
        - Default is Docker (may be Vagrant, rkt, cri-o, containerd or any other)
    - kubelet
        - Runs within a node
        - continuously interacts with kube-API Server
            - fetches what should be running on the present node
            - reports back its status
        - make sure the containers of the node are running
        - manages Container Runtime and Kube-proxy
    - Container Runtime
        - actually implements the containers
    - Kube-proxy
        - proxys all the requests across container/nodes on the cluster
        - allows services to communicate even if the containers/nodes have changed


## Pods

### What is a Pod
    - a pod is the basic unit of k8s
    - it can contain multiple containers
    - a pod is an isolated virtual host with
        - an unique (random) IP address
        - reachable from all other pods in the k8s cluster
        - own network namespace
        - virtual ethernet connection
    - contains at least a "pause" container
        - it is a placeholder container (usually called "sandbox")
        - reserves a pod's namespace
        - holds the pod and ist namespace if the 'main' container dies or gets replaced
    - pods are described on a pod manifest file
    - containers in the same pod scale together
    
### Why a Pod?
    - The concept was created to avoid port-mapping conflicts amongst the containers on the hosting machine.
    - Grants Container Runtime agnosticism - while changing the Container Runtime the K8s configuration stays the same.


#### Pods Manifest File


# KubeCTL


# Services
A service is a DNS name that can be used inside a cluster to communicate with a set of pods (a replica set) of a service while the pods get destroyed/updated/scaled.

Ex.:
A "Node Service" binds a port in each node of the cluster and then forwards that port to a set of pods. This may be under a load balancer.

# Ingress Controllers
These may be seen as subset of services as they can send you to a specific set of pods. However, you have (ex.: https) redirection logic.

# Deployments
Deployment --creates--> Replica Sets --create--> Pods
Deployments include `Roleback` and `no-downtime` deployment


# Setup Kubernetes

## Version skew
At  first glance, `kube-apiserver` should be the most recent version of all your components. Ideally, all the remaining components should be the the same version. Note that some components tolerate a skew of one or two minor versions.
For details on versions and skew check the ['Kubernetes version and version skew support policy'](https://kubernetes.io/docs/setup/release/version-skew-policy/)





# Config map
    a cool way of injecting configuration into a pod via environment variables or mount point.

## Secret
 You can set access rights to secrets



# Storage
    Docker volumes with some extentions


# Probes
## Liveness Probes
Monitor system health
http calls
    200-299 - all ok
    else    - not ok
## Rediness Probes
If service doesn't respond 200-299, instead of getting destroyed and rebuilt, the pod is removed from balancing rotation until it answers 200-299. This is useful if a pod gets over loaded with too many requests or a long running task. 




# Glossary

**controller** - a piece of software that continuously runs in the cluster, in the `kube-controler-manaer`, to grant that changes trigger effects.


# References
https://kubernetes.io/docs/home/
https://www.youtube.com/playlist?list=PLy7NrYWoggjziYQIDorlXjTvvwweTYoNC


