# Overview

This repository provides Ansible workflow for key provisining and customization tasks on ROSA cluster. Some of the activities covered in this guidance include:

* Prepare AWS environment for EFS and create EFS backed storage class on ROSA cluster
* Remove AWS environment for EFS and create EFS backed storage class on ROSA cluster
* Deploy IBM Maximo on ROSA cluster
* Uninstall Maximo from a ROSA cluster
* Backup Maximo on ROSA cluster
* Restore Maximo to ROSA cluster
* Upgrade Maximo on ROSA cluster

## Pre-requisites

Some pre-requisites:

* Existing ROSA cluster. ROSA cluster can be provisioned using Terraform. Please refer to [this](https://cloud.redhat.com/experts/rosa/terraform/hcp/) repository for steps.

## Versions

This is tested on ROSA cluster versions 4.14 and 4.15.

# Preparing EFS and File Storage Class

* Update variables in the ```mas-deployment-prep.yaml``` vars section.
* Login into the ROSA cluster via cli - ```oc login -u <username> -p <password> <api server url>```. Prefer using Admin account.
* Login to AWS Environment with account that has enough privileges to create EFS.

## Procedure to Prepare Create EFS and Storage Class

```Python
make virtualenv
make install-mas-dependencies
```

# Removing EFS and File Storage Class

* Update variables in the ```mas-remove-prep.yaml``` vars section.
* Login into the ROSA cluster via cli - ```oc login -u <username> -p <password> <api server url>```. Prefer using Admin account.
* Login to AWS Environment with account that has enough privileges to create EFS.

## Procedure to Remove Create EFS and Storage Class

```Python
make virtualenv
make remove-mas-dependencies
```

## Deploy Maximo

# Pre-requisites

* EFS and file backed storage classes are already completed as mentioned above.
* Update variables in the ```mas-remove-prep.yaml``` vars section.
* Login into the ROSA cluster via cli - ```oc login -u <username> -p <password> <api server url>```. Prefer using Admin account.
* Login to AWS Environment with account that has enough privileges to create EFS.

## Procedure to Deploy Maximo

```Python
make virtualenv
make install-mas-dependencies
make deploy-mas
```

## Procedure to Uninstall Maximo

Ensure that Suite and other components that requires removal are running

```Python
make virtualenv
make uninstall-mas
make remove-mas-dependencies
```

## Procedure to Backup Maximo

Ensure that Suite and other components that requires Backup are running. Have ```backup``` and ```backup-temp``` directories ready in ```artefacts``` directory. Update the variables with components that requires backup.

```Python
make virtualenv
make install-mas-dependencies
make backup-mas
```

## Procedure to Restore Maximo

Ensure that Suite and other components that requires restore are running. Update the variables with components that requires restore.

```Python
make virtualenv
make restore-mas
```

