**Table of Contents**
- [Tekton CICD Administration Steps](#tekton-cicd-administration-steps)
  - [How it works](#howitworks)
    - [clusterTask](#clusterTask)
    - [pipeline](#pipeline)
    - [pipelineRun](#pipelineRun)
  - [How to run it](#howtorunit)
    - [Initial script](#initialscript)
    - [How to onbaord a new xxx](#howtoonboardanewxxx)
- [Useful Documentation](#useful-documentation)
  - [Resources](#resources)

## Tekton CICD Administration Steps
This repository holds administration steps to be taken prior to a Standardized Container Docker Image CICD workflow to be executed. This includes 
  1. Creating a namespace for the tenant to run in CloudHarbor
  2. Creating a secret to push images/helm chart into the Harbor registry
  3. Creating a secret that holds the kubeconfig for the remote cluster

### How it works
The administrator will create clusterTasks that define reusable tasks that can be ran within a pipeline. These tasks are created within the default namespace and are accessible by all other namespaces.

A generic tekton pipeline ./pipeline/p-run-kubectl-command.yaml will be created that uses the git-clone and generic-script clusterTasks. First the cluster-admin pipeline will be cloned and the generic-script task will run the script given via parameters. For example, the pr-create-ns.yaml pipelineRun object runs a command to create a namespace "kubectl create ns $(params.set-namespace)".

A pipelineRun object is created to create a new namespace, add any required RBAC, and create any required secrets for each xxx.

* clusterTask
A clusterTask is reusable by any namespace and accessible across the cluster. The administrator will execute the pipelineRun object located at ./tekton/catalog/pipelineRun/pr-create-tasks.yaml to create any required tasks for xxx. Any updates required by xxx will need to be requested by the administrator and versioned to simplify support/troubleshooting.

* pipeline
The pipeline found at ./tekton/catalog/pipeline/p-run-kubectl-command.yaml is a generic pipeline that accepts specific parameters to allow multiple pipelineRun objects to execute different script commands.

* pipelineRun
The pipelineRun objects found at ./tekton/catalog/pipelineRun execute the p-run-kubectl-command by passing different parameters to the generic script clusterTask. 
  1. ./pr-create-tasks.yaml - Creates all clusterTasks required for xxx CICD workflows.
  2. ./pr-create-ns.yaml - Creates a namespace by setting the set-namespace parameter
  3. ./pr-create-rbac.yaml - Creates all required k8s RBAC objects for the given namespace 
  4. ./pr-create-secrets.yaml - Creates secrets for Harbor credentials and remote cluster kubeconfig to deploy to.

### How to Run it
#### Initial script
1. One time script to create required clusterTask and pipeline to be used for each xxx.
   00-setup.sh

#### Onboarding a new xxx
1. Copy the ./tetkon/catalog/pipelineRun/template directory and name it whatever namespace you are creating.
   Example: cnf-a directory
2. Update parameters in each of your pr-*.yaml files.
3. Submit a patchset and get reviews on the new namespace definition.
4. TODO - setup Tekton trigger to run each pipelineRun object and check validation pr-validate-onboard-setup.yaml
     
### Useful Documentation
#### Resources
[pipeline resources](https://github.com/tektoncd/pipeline/blob/master/docs/resources.md)
  * [Git Resources](https://github.com/tektoncd/pipeline/blob/master/docs/resources.md#git-resource) 
  * [Image Resource](https://github.com/tektoncd/pipeline/blob/master/docs/resources.md#image-resource) is used to define
    the docker image to use
[pipeline parameters](https://github.com/tektoncd/pipeline/blob/master/docs/pipelines.md#parameters) to specify what application to build and the image to create

