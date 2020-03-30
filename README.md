# k8s-devops-toolkit
All needed tools for a gentle Dev-Ops

#### Summary
- [Install](#install)
- [Usages](#usages)
   * [Build Image](#build-image)
   * [Start container](#start-container)
   * [Configuration](#configuration)
      - [First init of GCloud](#first-init-of-gcloud)
      - [Add and authenticate GKE Cluster](#add-and-authenticate-gke-cluster)
   * [List of commands](#list-of-commands)
      - [Glogals](#glogals)
      - [Other](#other)
      - [Publishing](#publishing)
      - [Global parameters](#global-parameters)
   * [List of container alias](#list-of-container-alias)
- [Advanced usage](#advanced-usage)
- [Contribute](#contribute)

## Install

1. Clone this project repository into your computer.

2. To add to your to your favorite `shell` the KDT alias to access quickly to the batch of
   commands, launch one of those lines, depending of your shell.
   ```bash
   # For ZSH
   echo "alias kdt=\"$(make print-alias)\"" >> ~/.zshrc

   # For Bash
   echo "alias kdt=\"$(make print-alias)\"" >> ~/.bashrc
   ```  

3. [Build](#build-image) your image and [configure](#configuration) your Kubernetes clusters
 
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

### Start container

To start a container with all tools

```bash
# Into the the project folder
make attach [FOLDER=<folder-path-to-mount>] [PORT=<port-number>] [DEBUG=false|*]

# From everywhere with the alias
## FOLDER parameter is automaticaly set with 'kdt' alias with the current folder
kdt attach [PORT=<port-number>] [DEBUG=false|*]
```

[Top](#summary)

### Configuration

#### First init of GCloud

```bash
# Go into the container
kdt attach

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

### List of commands

#### Glogals

   - **build** : Build local docker image of KDT
   - **remove** : Remove local docker image of KDT
   - **attach**: Start a container of image KDT in interactive mode
      * FOLDER *(default: false, ex: /my/folder/path)*<br>
        Define the folder to mount into the container.<br>
        If you'r using the shell alias `kdt` this variable is set with the current folder.
      * PORT *(default: false, ex: 2222)*<br>
        Define the port binded on the host to give access to your web browser or your 
        ssh client.
      * DOCKER *(default: false, ex: true)*<br>
        Set if you need to mount the docker daemon socket into the container.

[Top](#summary)

#### Other
   - **help** : Display help
   - **print-alias** : Print shortcut command for your alias file
   - **version** : Get the current version

[Top](#summary)

#### Publishing
   - **publish** : Publish images into the registry
   - **version-bump** : Bump version
      * BUMP_TYPE *(values: major | minor | patch)* <br>
        Define witch type of bump you want to apply.

[Top](#summary)

#### Global parameters

* DEBUG *(default: false, ex: 1)*<br>
  Display all information from Docker command into the prompt.

[Top](#summary)

#### List of container alias

**GCloud**
 - **gci** : gcloud beta interactive

**Kube**
 - **k**, **kc** : kubectl
 - **ke** : kubectl exec -it
 - **logs** : kubectl logs
 - **nodes** : kubectl get nodes
 - **pods** : kubectl get pods
 - **jobs** : kubectl get jobs
 - **np** : kubectl get networkpolicies
 - **secrets** : kubectl get secrets
 - **services** : kubectl get services
 - **kp** : kubeon
 - **nokp** : kubeoff
 - **sa** : kubectl get serviceaccounts
 - **kx** : kubectx
 - **kn** : kubens

**Network**
 - **telnet** : busybox-extras telnet

**Other**
 - **l** : ls -CF
 - **la** : ls -A
 - **ll** : ls -alF
 - **ls** : ls --color=auto

[Top](#summary)

## Advanced usage

Here, found all usecases usefull commands.

[Top](#summary)

## Contribute

The best practice is to make a Merge Request.

[Top](#summary)