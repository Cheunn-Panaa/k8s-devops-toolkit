# KDT (k8s devops toolkit)

## Summary

* [Install](#install)
* [Usages](#usages)
  * [Build Image](#build-image)
  * [Start container](#start-container)
  * [Configuration](#configuration)
    * [First init of GCloud](#first-init-of-gcloud)
    * [Add and authenticate GKE Cluster](#add-and-authenticate-gke-cluster)
  * [List of commands](#list-of-commands)
    * [Glogals](#glogals)
    * [Defaults](#defaults)
    * [Publishing](#publishing)
    * [Global parameters](#global-parameters)
  * [List of container alias](#list-of-container-alias)
* [Advanced usage](#advanced-usage)
* [Contribute](#contribute)

## Install

1. Clone this project repository into your computer.

   ```bash
   git clone git@gitlab.com:dolmen-tech/tools/k8s-devops-toolkit.git
   ```

2. Install Awesome Makefile Framework.

   ```bash
   cd k8s-devops-toolkit

   curl -sL https://github.com/BROUSSOLLE-Brice/awsome-makefile-framework/releases/latest/download/installer | sh
   ```

3. To add to your to your favorite `shell` the KDT alias to access quickly to the batch of
   commands, launch one of those lines, depending of your shell.

   ```bash
   # For ZSH
   echo "alias kdt=\"`make print-alias`\"" >> ~/.zshrc

   # For Bash
   echo "alias kdt=\"`make print-alias`\"" >> ~/.bashrc
   ```  

4. [Build](#build-image) your image and [configure](#configuration) your Kubernetes clusters

[Top](#summary)

## Usages

Using the basic Docker images permite to have the simplest way to start the KDT tools
and ansure all configs, auth files are saved into the current user home directory.

### Build Image

Build images is used when you install for the first time or after the update of the
project.

```bash
# Into the the project folder
make build

# From everywhere with the alias
kdt build
```

[Top](#summary)

### Help

To display general help use the command `kdt help`.

For more detailed help per command use the command `kdt <command> HELP=true`.

[Top](#summary)

### Configuration

- [Configure for GCloud](#####Configure for GCloud)
- [Configure for AWS](./docs/AWS.md)
- [Configure for Azure](./docs/Azure.md)


#### Configure for GCloud
```bash
# Go into the container
kdt

# Follow the instruction of the command gcloud init
gcloud init
```

[Top](#summary)

#### Add and authenticate GKE Cluster

```bash
# The authentication command looks like this:
gcloud container clusters get-credentials <CLUSTER_NAME> --region <REGION> --project <PROJECT_NAME>

# To help you during Operational phase, rename the cluster name like this example:
kx production=gke_kogus-production_europe-west1_pkub
```

[Top](#summary)

#### List of container alias

##### Kube

* **k**, **kc** : kubectl
* **ke** : kubectl exec -it
* **kpf** : kubectl port-forward --address=0.0.0.0  
* **logs** : kubectl logs
* **nodes** : kubectl get nodes
* **pods** : kubectl get pods
* **jobs** : kubectl get jobs
* **np** : kubectl get networkpolicies
* **secrets** : kubectl get secrets
* **services** : kubectl get services
* **kp** : kubeon
* **nokp** : kubeoff
* **sa** : kubectl get serviceaccounts
* **kx** : kubectx
* **kn** : kubens

##### Network

* **telnet** : busybox-extras telnet

##### Other

* **l** : ls -CF
* **la** : ls -A
* **ll** : ls -alF
* **ls** : ls --color=auto
* **bat** : cat with wings and syntax highlighting, for yaml, md ...

[Top](#summary)

## Modules

KDT use multiple kind of [modules](./docs/README.md) activated by user profiles.

[Top](#summary)

## Contribute

The best practice is to make a Merge Request.

[Top](#summary)
