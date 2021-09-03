### Create tfstate bucket in helm env for state management
Create or use `tfstate`
```bash

export BUCKET_NAME=project94
export REGION=europe-west6
export PROJECT_NAME=natural-aria-324506

# Check whether bucket exists
gsutil ls -r gs://$BUCKET_NAME-tfstate/
# Create bucket
gsutil mb -p $PROJECT_NAME -c STANDARD -l $REGION -b on gs://$BUCKET_NAME-tfstate/
# Enable versioning on tfstate bucket
gsutil versioning set on gs://$BUCKET_NAME-tfstate/

```

## Terraform commands 
```bash
terraform init
terraform plan -var-file=dev.tfvars -out=dev.out
terraform apply "dev.out"
terraform plan -var-file=dev.tfvars -out=dev.out -target=google_storage_bucket.gcs_bucket
```

## Connect to bastion host 
```
export HTTPS_PROXY=localhost:8888

gcloud compute ssh project94-cluster-bastion --project natural-aria-324506 --zone europe-west6-a -- -L8888:127.0.0.1:8888
```

## Connect to K8S 
```

export HTTPS_PROXY=localhost:8888

gcloud container clusters get-credentials project94-cluster --zone europe-west6-a --project natural-aria-324506 --internal-ip



kubectl config get-contexts
kubectl get po -A
```

## Get Jenkins creds
```
kubectl get secrets project94-jenk-jenkins -ojsonpath='{.data.jenkins-admin-password}' | base64 -d

```