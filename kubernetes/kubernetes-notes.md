# **Kubernetes**
Kubernetes (K8s) is a container orchestration application designed to optimize deployment, scaling and resource utilization.

*Kubernetes* is Desired State Configuration (DSC) oriented - not action oriented. Provided the DSC Files, *K8s* will take the necessary actions to grant that the described state is implemented.

All the notes below assume that *Kubernetes* is used as programmatically as possible. Ideally you want to only edit the DSC File, provide new artifacts and let *K8s* do its job.

\
\
\
\
\
.
# **Architecture Overview**

A fine overview may be found on the [official documentation](https://kubernetes.io/docs/concepts/).

\
\
\.
## **Cluster**
A Cluster is the full-fledged unit that hosts/runs/serves your application/service/platform. It is composed of:
- a **Controle Plane** which orchestrates the remaining parts to bring the status of the cluster to the DSC.
- a/several **Worker Node**(s) which contain the actual operating components in containerized environments.
- (optionally) a/several **Cloud Provider API**(s) that may be used to interface with external applications/services/platforms (ex.: a firewall).

NOTE: On Cloud Services, the *Control Plane* node is not configured but directly provided to you. The worker nodes, on the other hand are alway configurable.

\
\
\.
## **Control Plane** 
A *Control Plane* contains:

    - a `kube-apiserver`
    - an `etcd` storage unit
    - a `kube-scheduler`
    - a `kube-controller-manager`
    - (optionally) a `cloud-controler-manager`

All together, the *Control Plane*:
- holds the CSD File
- holds the (very volatile) current state description 
- handles external requests (ex.: from the users)
- handles communication with/amongst pods
- decides if nodes/pods should be created or destroyed
- sorts pods across nodes
Notice that the *Control Plane* is an abstraction layer which solely sets organization and structure and is mostly agnostic to you application, providers or configurations. 

\.
### **The `kube-apiserver`**
The `kube-apiserver` is the front end server for the Kubernetes control plane. It exposes the *Kubernetes* API.

Users, administrators, other *Control Plane* components, *Worker Node* components (such as *kubelets* and *kube-proxys*), and generally all interaction use this API.

The main implementation of a Kubernetes API server is kube-apiserver. kube-apiserver is designed to scale horizontally—that is, it scales by deploying more instances. You can run several instances of kube-apiserver and balance traffic between those instances.


\.
### **The `etcd`**
The `etcd` is a consistent and highly-available key value store used as Kubernetes' backing store for all cluster data. Amongst others, it holds:
- a representation of the Desired State Configuration File
- a representation of the actual current state
- locks

\.
### **The `kube-scheduler`**
The `kube-scheduler` is the *Control Plane* component that watches for newly created Pods with no assigned node, and selects a node for them to run on.

Factors taken into account for scheduling decisions include: individual and collective resource requirements, hardware/software/policy constraints, affinity and anti-affinity specifications, data locality, inter-workload interference, and deadlines.

- gets the available resources and its current status
- identifies/defines the nodes to deploy - assigns different worker node names to the DSC
- stores the new state configuration in the `etcs`.

\.
### **The `kube-controller-manager`**
The `kube-controller-manage` is a single binary that runs as a single process but actually runs four different services that may be seen as four logically independent processes:
- The **Node Controller** - Responsible for noticing and responding when nodes go down.
- The **Replication Controller** - Responsible for maintaining the correct number of pods for every replication controller object in the system.
- The **Endpoints Controller** - Which populates the Endpoints object (that is, joins Services & Pods).
- The **Service Account & Token Controllers**: Create default accounts and API access tokens for new namespaces.

\.
### **The `cloud-controller-manager`**
The `cloud-controller-manager` is a  *Control Plane* component that embeds cloud-specific control logic. The cloud controller manager lets you link your cluster into your cloud provider's API, and separates out the components that interact with that cloud platform from components that just interact with your cluster.

As with the kube-controller-manager, the cloud-controller-manager combines several logically independent control loops into a single binary that you run as a single process:
- The **Node controller** - Checks the cloud provider to determine if a node has been deleted in the cloud after it stops responding
- The **Route Controller** - Sets up routes in the underlying cloud infrastructure
- The **Service Controller** - Creates, updates and deletes cloud provider load balancers.


\
\
\.
## **Worker Node**
A Worker node contains:

    - a `kubelet`
    - a `kube-proxy`
    - a Container Runtime
This is where your application actually runs. The *Worker Nodes* manage *Pods* inside which the containers actually run the tasks of your application. The *"Node"* abbreviation is typically used when referencing a *Worker Node*.  

\.
### **The `kubelet`**
The `kubelet` is an agent that runs on each *Worker Node* in the cluster. It ensures that the *Container Runtime* containers are running in a Pod and that the `kube-proxy` rules are kept coherent with the *Control Plane*. 

The `kubelet` continuously interacts with the `kube-apiserver` to ensure that the containers described in the `etcd` PodSpecs are running and healthy. The status of the *Pods* is then reported back to the `kube-apiserver`.

The kubelet doesn't manage containers which were not created by Kubernetes.

\.
### **The `kube-proxy`**
The `kube-proxy` is a network proxy that runs on each node in a cluster.

By using the operating system packet filtering layer (if available) or forwarding the traffic itself, the `kube-proxy` maintains the network rules on nodes allowing communication across containers/pods/nodes.

By proxying the services, `kube-proxy` provides a static reference to a service even if the container/pod/node/location of the service has changed. This implement part of the Kubernetes Service concept.

\.
### **The *Container Runtime***
The *Container Runtime* is the software responsible for managing the containers inside each *Pod*.

The default *Container Runtime* is Docker but *Kubernetes* is agnostic to the *Container Runtime* provider. (may be Vagrant, rkt, cri-o, containerd or any other)

\
\.
## **Pods**
### **What is a *Pod*?**
- a *Pod* is the basic unit of k8s
- it can contain multiple containers
- a pod is an isolated virtual host with
    - an unique (random) IP address
    - reachable from all other pods in the k8s cluster
    - own network namespace
    - virtual ethernet connection
- contains at least a "pause" container
    - it is a placeholder container (usually called dbox")
    - reserves a pod's namespace
    - holds the pod and ist namespace if the 'main' ainer dies or gets replaced
- pods are described on a pod manifest file
- containers in the same pod scale together
    
### Why a Pod?
- The concept was created to avoid port-mapping conflicts amongst the containers on the hosting machines.
- Grants Container Runtime agnosticism - while changing the Container Runtime the K8s configuration stays the same.
- a "pause" container grants that a pod is kept even if all the application containers in it die.

\
\
\
\
\
.
# CLI Tools
You can interact with each component of a k8s cluster via CLI. 

## Configuration Tools
Even though the configuration should always be handle through the DSC File, you can set/change configurations on the fly. A full reference on how to interact with several components may be found in the [official documentation](https://kubernetes.io/docs/reference/command-line-tools-reference/).

## kubectl CLI
Once you've configured your cluster you can interact with your application and its component using the `kubectl` CLI application.

`kubectl` is a CLI to handle kubernetes functionalities. You can find the full documentation in the [official kubectl CLI documentation](https://kubernetes.io/docs/reference/kubectl/)

























## Debug Methods
For the complete, updated and official list of the debugging methods you may check the [kubernetes documentation on *"Monitoring, Logging and Debugging"*](https://kubernetes.io/docs/tasks/debug-application-cluster/).

### Check Pod Logs
To check the logs on a running pod/container you may use:

    kubectl logs ${POD_NAME} ${CONTAINER_NAME}
If one of your containers has crashed, you can check its crash logs with:

    kubectl logs --previous ${POD_NAME} ${CONTAINER_NAME}

### Commands on Containers
You may run any command on your container using:

    kubectl exec ${POD_NAME} -c ${CONTAINER_NAME} -- ${CMD} ${ARG1} ${ARG2} ... ${ARGN}
The particular case of running a shell connected to your terminal is of particular interest. For that you'll need to use the flags `-t` (to assign a tty to your terminal) and `-i` (to make you interact with that tty). The command would be:

    kubectl exec -it ${POD_NAME} -- sh
Another interesting case could be sending a local script to run inside a container with:

    kubectl exec -it ${POD_NAME} -- sh -c "${PATH_TO_SCRIPT}"
\
\
\
\
\
.
# Kubernetes Features

# Services
A service is a DNS name that can be used inside a cluster to communicate with a set of pods (a replica set) of a service while the pods get destroyed/updated/scaled.

Ex.:
A "Node Service" binds a port in each node of the cluster and then forwards that port to a set of pods. This may be under a load balancer.

# Ingress Controllers
These may be seen as subset of services as they can send you to a specific set of pods. However, you have (ex.: https) redirection logic.

# Deployments
Deployment --creates--> Replica Sets --create--> Pods
Deployments include `Roleback` and `no-downtime` deployment

\
\
\
\
\
.
# Setup Kubernetes

## Version skew
At  first glance, `kube-apiserver` should be the most recent version of all your components. Ideally, all the remaining components should be the the same version. Note that some components tolerate a skew of one or two minor versions.
For details on versions and skew check the ['Kubernetes version and version skew support policy'](https://kubernetes.io/docs/setup/release/version-skew-policy/)





# Config Map
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



\
\
\
\
\
.
# Glossary

**Cluster**

**Control Plane**

**controller** - a piece of software that continuously runs in the cluster, in the `kube-controler-manager`, to grant that changes trigger effects.

**Deployments**

**Ingresses**

**Node**

**Pod**

**Probes**

**Secrets**

**Services**



\
\
\
\
\
.
# References
https://kubernetes.io/docs/home/

https://www.youtube.com/watch?v=lAyL9HKx8cQ

https://www.youtube.com/playlist?list=PLy7NrYWoggjziYQIDorlXjTvvwweTYoNC

https://www.youtube.com/hashtag/kubernetesbestpractices



