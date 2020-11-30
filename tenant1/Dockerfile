# Copyright 2019 AT&T Intellectual Property.  All other rights reserved.
ARG FROM=ubuntu:18.04
FROM ${FROM} as build

RUN set -ex ;\
    apt-get update -y ;\
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg \
        apt-transport-https \
        git ;\
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - ;\
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list ;\
    apt-get update ;\
    apt-get install -y --no-install-recommends \
        kubectl ;\
    curl -sSL https://github.com/helm/helm/archive/v2.16.10.tar.gz | bash ;\
    helm init --client-only ;\
    helm plugin install https://github.com/chartmuseum/helm-push;

COPY "./standardized_scripts/00-init.sh" "/usr/local/bin/"
COPY "./standardized_scripts/01-quality-check.sh" "/usr/local/bin/"
COPY "./standardized_scripts/02-deploy.sh" "/usr/local/bin/"
COPY "./standardized_scripts/03-test.sh" "/usr/local/bin/"
COPY "./standardized_scripts/04-publish.sh" "/usr/local/bin/"
COPY "./standardized_scripts/05-cleanup.sh" "/usr/local/bin/"
