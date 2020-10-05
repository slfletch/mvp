#!/bin/bash
set -ex
#Initialize helm
helm init --client-only
#Install required plugins
helm plugin install https://github.com/chartmuseum/helm-push