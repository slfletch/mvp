# Copyright 2019 AT&T Intellectual Property.  All other rights reserved.
ARG FROM=mtn52r08c001.mini.mtn52c.cci.att.com:30003/library/dependencies/ubuntu:20.04
FROM ${FROM} as build

ENV http_proxy=http://pxyapp.proxy.att.com:8080
ENV HTTP_PROXY=http://pxyapp.proxy.att.com:8080
ENV https_proxy=http://pxyapp.proxy.att.com:8080
ENV HTTPS_PROXY=http://pxyapp.proxy.att.com:8080

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

# Copying the directory repeatedly yielded this error:
# error building image: error building stage: failed to get files used from context: when specifying multiple sources in a COPY command, destination must be a directory and end in '/'
COPY "standardized_scripts/run.sh" "/usr/local/bin/"
COPY "standardized_scripts/setup.sh" "/usr/local/bin/"
COPY "standardized_scripts/test.sh" "/usr/local/bin/"

CMD ["/usr/bin/tail", "-f", "/dev/null"]

