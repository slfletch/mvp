#!/bin/bash
set -ex

#Create the 2 cluster tasks that are required
kubectl create -f ./tekton/catalog/clustertask/git-clone/git-clone.yaml
kubectl create -f ./tekton/catalog/clustertask/generic-script/generic-script.yaml

#Create the pipeline that will clone the given repo and create all clusterTasks that are defined.
kubectl create -f ./tekton/catalog/pipeline/p-run-kubectl-command.sh

#Create all clusterTasks
kubectl create -f ./tekton/catalog/pipelineRun/pr-create-clustertasks.yaml
