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
