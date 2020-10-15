# Copyright 2019 AT&T Intellectual Property.  All other rights reserved.
ARG FROM=ubuntu:20.04
FROM ${FROM} as build

ENV HTTPS_PROXY="${HTTP_PROXY}"
ENV HTTPS_PROXY="${HTTPs_PROXY}"
ENV NO_PROXY="${NO_PROXY}"
ENV http_proxy="${HTTP_PROXY}"
ENV https_proxy="${HTTPS_PROXY}"
ENV no_proxy="${NO_PROXY}"

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
    helm plugin install https://github.com/chartmuseum/helm-push;

COPY "tenant1/standardized_scripts/*.sh" "/usr/local/bin/"