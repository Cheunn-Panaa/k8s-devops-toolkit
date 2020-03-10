# k8s-devops-toolkit
All needed tools for a gentle Dev-Ops

## Quickstart

### Install
```bash
cd git; mkdir tools; cd tools
git clone git@gitlab.com:dolmen-tech/tools/k8s-devops-toolkit.git
```

### Build Docker Image
```bash
make image-build
```

### Run Docker Image
```bash
make image-attach
```


### Configure
```bash
gcloud init

gcloud container clusters get-credentials pkub --region europe-west1 --project kogus-production
kx production=gke_kogus-production_europe-west1_pkub

gcloud container clusters get-credentials pkub --region europe-west1 --project kogus-staging
kx staging=gke_kogus-staging_europe-west1_skub

gcloud container clusters get-credentials playground-kub --zone europe-west4-c --project kogus-playground
kx playground=gke_kogus-playground_europe-west4-c_playground-kub
```

### Test
```bash
kubectx
```

## Commands

Are based on make file, all commands must start with `make`.

### Image commands

| Commands         | Options |  Descriptions                           |
|------------------|---------|-----------------------------------------|
| **image-build**  |         | Build docker image                      |
| **image-remove** |         | Remove docker image                     |
| **image-attach** |         | Create docker container & attach Shell  |

### Env commands

| Commands       | Options |  Descriptions                           |
|----------------|---------|-----------------------------------------|
| **env-build**  |         | Build docker env                        |
| **env-remove** |         | Remove docker env                       |
| **env-attach** |         | Create docker container & attach Shell  |

### Publication commands

| Commands           | Options      |  Descriptions                           |
|--------------------|--------------|-----------------------------------------|
| **version**        |              | Get current version                     |
| **version-change** | VERSION_TYPE | Bump version, commit, tag and push      |
| **publish**        |              | Publish docker image                    |

#### Options
 - **VERSION_TYPE** :
    * patch
    * minor
    * major