#!/bin/bash
set -ex

#Create temporary directory
build_dir=$(mktemp -d)
cd $build_dir
git clone https://github.com/openstack/openstack-helm-infra.git
cd openstack-helm-infra/
mkdir -p ./rabbitmq/charts
cp -rav ./helm-toolkit ./rabbitmq/charts/
#Package rabbitmq chart
helm package ./rabbitmq

#Check if the overall product renders
helm lint ./rabbitmq-0.1.2.tgz

helm push --ca-file /workspace/source/temp-ca.crt --username=admin --password=Harbor12345 rabbitmq-0.1.2.tgz test
