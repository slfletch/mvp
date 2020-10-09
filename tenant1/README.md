**Table of Contents**
- [Tekton Standardized Container Build Process with Tekton pipelines](#tekton-standardized-container-build-process-with-tektoncd-pipelines)
  - [How it works](#howitworks)
    - [./standardized scripts](#./standardized-scripts)
    - [./Dockerfile](#./Dockerfile)
    - [./tekton/pipelineResources/pres-create-scdi.yaml](#./tekton/pipelineResources/pres-create-scdi.yaml)
    - [./tekton/pipelines/p-create-scdi.yaml](#./tekton/pipelines/p-create-scdi.yaml)
    - [./tekton/pipelineRuns/prun-create-scdi.yaml](#./tekton/pipelineRuns/prun-create-scdi.yaml)
- [Useful Documentation](#useful-documentation)

## Tekton Standardized Container Build Process with Tekton pipelines
This directory contains Tekton pipelines intended to rebuild your standardized container docker image that will include
all of the steps required to deploy your CNF.
### How it works
* ./standardized_scripts
Set of scripts that will allow you to define the steps required for your CI/CD requirements. The names of the scripts should
not be changed and you have the ability to define what each script does. You are not required to use each script and new script
names can be added by contacting an administrator so that they stay consistent across all CNF deployments.
  1. 00-setup.sh
  Example script initializes helm client
  2. 01-ci.sh
  Example script builds, packages(versions), helm lint, and publishes into a test location of Harbor Helm Repository
  3. 02-cd.sh
  Example downloads test helm chart from Harbor and installs the helm chart into the local cluster
  4. 03-test
  Example tests the rabbitmq helm chart deployed in step 02 and executes a helm test on it.
  5. 04-publish.sh
  TODO (Stacey) Example moves the tested helm chart into its final destination for promotion in Harbor.
  6. 05-cleanup.sh
  TODO (Stacey) Example deletes the deployed helm chart from the local cluster.
* ./Dockerfile
Found at the root of your repository and defines how to package the Standardized Container Docker Image (SCDI). The current example is
  1. Has BASE_IMAGE of Ubuntu:20.04 (Line 2)
  2. Sets the proxy Environment variables if required (Line 5-10)
  3. Installs any required packages to execute the standardized scripts (Line 12-28)
  4. Copies the standardized scripts into the Docker image to be utilized by Tekton pipelines (Line 30)
your CNF.
* pipelineResource/pres-create-scdi.yaml defines the resources required to build your standardized container docker image.
  1. Creates a Persistent Volume Claim (pvc) in your defined namespace
  2. Creates a Deployment object for your Docker-in-Docker (DIND) build process
  3. Creates a Service to your defined DIND registry
* pipelines/p-create-scdi.yaml defines a reusable pipeline that calls on the shared clusterTasks in the default namespace. This Tekton pipeline definition does not execute any of the steps but creates the Tekton pipeline object that will executed when the
PipelineRun object is created.
  1. Clone your git repository that holds your Dockerfile and standardized scripts.
  2. Builds and Versions your standardized container to be used for your CI/CD workflow.
  3. Publishes and Scans your standardized container for any Vulnerabilities in Harbor
* pipelineRuns/prun-create-scdi.yaml launches a pipeline to build a specific application, in this case the build of the standardized container docker image (scdi).yaml at a specific commit 
  that uses this pipeline

### Run a pipeline
To create your SCDI explained above you can run the following steps that will result in a container published into Harbor that will be utilized to run your CNF's CI/CD workflow.
1. Administrator will have created a shared clusterTasks, namespace and RBAC controls required prior to steps 2-4.
   * **namespace**: **cnf-a**
2. Create the PipelineResources
   * kubectl create -n cnf-a -f ./tekton/pipelineResource/pres-create-scdi.yaml
3. Create the Pipeline definition
   * kubectl create -n cnf-a -f ./tekton/pipelines/p-create-scdi.yaml
4. Create the PipelineRun that will immediately execute the pipeline created in Step 3.
   * TODO (Stacey) Bring pipeline parameters out to the pipelineRun definition instead of pipeline.
This will result in a scdi image published into Harbor docker registry at mtn52r08c001.mini.mtn52c.cci.att.com:30003/tenent0/scdi:1.1
     
### Useful DocumentationResources 
[pipeline resources](https://github.com/tektoncd/pipeline/blob/master/docs/resources.md)
  * [Git Resources](https://github.com/tektoncd/pipeline/blob/master/docs/resources.md#git-resource) 
  * [Image Resource](https://github.com/tektoncd/pipeline/blob/master/docs/resources.md#image-resource) is used to define
    the docker image to use
[pipeline parameters](https://github.com/tektoncd/pipeline/blob/master/docs/pipelines.md#parameters) to specify what application to build and the image to create

