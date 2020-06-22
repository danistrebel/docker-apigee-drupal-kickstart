Apigee Dev Portal Kickstart Drupal + Docker
---

Using the `quick-start` command is great on your local machine, but doesn't play nice in a Docker container.

Here is simple setup that lets you run the Apigee Drupal Kickstarter in a Docker container. This image is for local development purposes. This is not intended for a production setup. Please refer to the [Documentation](https://docs.apigee.com/api-platform/publish/drupal/open-source-drupal-8) for installation, configuration and production hosting considerations.

See [here](https://github.com/apigee/apigee-devportal-kickstart-drupal) for the Drupal Installation Profile that this image is based on.

## Features
- Apigee Kickstart profile installed
- Drupal REST UI installed
- REST endpoints configure for Apigee Entities

## Usage

### Option A: Local Deployment

``` bash
export APIGEE_ORG=xxx
export APIGEE_USER=xxx
export APIGEE_PASS=xxx

#optionally if you are Private Cloud
export APIGEE_MGMT=(management server url)

# build and run the container
./start.sh
```

Navigate to `localhost:8080` and you will see an Apigee Portal installed with demo content.

Default admin credentials for the portal are: `admin@example.com` and `pass`, but you can change these in `start.sh`.

## Option B: Deployment to GKE

Requirement: A provisioned GKE cluster.

```bash
# GKE Cluster
export GKE_NAME=apigee-tools
export GKE_ZONE=us-central1-c

# Dev Portal Admin Account
export ADMIN_USER="admin@example.com"
export ADMIN_PASS="pass"

# Apigee Credentials
export APIGEE_ORG=xxx
export APIGEE_USER=xxx
export APIGEE_PASS=xxx
export APIGEE_MGMT='https://api.enterprise.apigee.com/v1' # or custom for OPDK

# Create a K8s Secret for the Apigee Credentials
kubectl create secret generic apigee-credentials \
  --from-literal org=$APIGEE_ORG \
  --from-literal password=$APIGEE_PASS \
  --from-literal username=$APIGEE_USER \
  --from-literal endpoint=$APIGEE_MGMT

# Submit Cloud Build Run for build and deployment
gcloud builds submit --config cloudbuild.yaml \
  --substitutions=_ADMIN_USER=$ADMIN_USER \
  --substitutions=_ADMIN_PASS=$ADMIN_PASS \
  --substitutions=_CLUSTER_NAME=$GKE_NAME \
  --substitutions=_CLUSTER_ZONE=$GKE_ZONE
```

## Disclaimer

This is not an official Google Product.
