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

#Get certificate from Harbor helm repository - Hardcoded for time purposes, in a non-POC world this ca would be bind mounted into the container
kubectl get -n harbor secrets harbor-release-harbor-nginx -o 'go-template={{ index .data "ca.crt" | base64decode }}' > ./temp-ca.crt

#Adding the chart repository to helm
helm push --ca-file harbor-ca.crt --username=admin --password=Harbor12345 ./test/rabbitmq-0.1.0.tgz nrf
