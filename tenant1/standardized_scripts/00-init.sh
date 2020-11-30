#!/bin/bash
set -ex
#Initialize helm
helm init --client-only
#Install required plugins
helm plugin install https://github.com/chartmuseum/helm-push

kubectl get -n harbor secrets harbor-release-harbor-nginx -o 'go-template={{ index .data "ca.crt" | base64decode }}' > ./temp-ca.crt

helm repo add --ca-file ./temp-ca.crt test https://benld.localdomain:30003/chartrepo/test
helm repo add --ca-file ./temp-ca.crt nrf https://benld.localdomain:30003/chartrepo/nrf

