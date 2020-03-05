# k8s-devops-toolkit
All needed tools for a gentle Dev-Ops

## Commands

Is based on make file, all commands must start with `make`.

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