# Copyright 2019 AT&T Intellectual Property.  All other rights reserved.
ARG FROM=ubuntu:20.04
FROM ${FROM} as build

ENV HTTP_PROXY="http://pxyapp.proxy.att.com:8080/"
ENV HTTPS_PROXY="http://pxyapp.proxy.att.com:8080/"
ENV NO_PROXY="127.0.0.1,localhost,.att.com,10.96.0.0/12,.svc.cluster.local,32.68.220.18,.tekton-pipelines.svc,192.168.0.0/16"

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
    curl -sSL https://git.io/get_helm.sh | bash ;\
    helm init --client-only ;\
    helm plugin install https://github.com/chartmuseum/helm-push

COPY "tenant1/standardized_scripts/*.sh" "/usr/local/bin/"