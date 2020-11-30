#!/bin/bash
#This can be done using Flux - flexibility of the pipeline, encapsulation in a script can be executed.
#kubectl get -n harbor secrets harbor-release-harbor-nginx -o 'go-template={{ index .data "ca.crt" | base64decode }}' > ./temp-ca.crt
tee /tmp/values.yaml <<EOF

images:
  tags:
    prometheus_rabbitmq_exporter: benld.localdomain:30003/nrf/kbudde/rabbitmq-exporter:v0.21.0
    prometheus_rabbitmq_exporter_helm_tests: benld.localdomain:30003/nrf/openstackhelm/heat:stein-ubuntu_bionic
    rabbitmq_init: benld.localdomain:30003/nrf/openstackhelm/heat:stein-ubuntu_bionic
    rabbitmq: benld.localdomain:30003/nrf/rabbitmq:3.7.26
    dep_check: benld.localdomain:30003/nrf/airshipit/kubernetes-entrypoint:v1.0.0
    scripted_test: benld.localdomain:30003/nrf/rabbitmq:3.7.26-management
    image_repo_sync: benld.localdomain:30003/nrf/docker:17.07.0
labels:
  server:
    node_selector_key: harbor
    node_selector_value: enabled
  prometheus_rabbitmq_exporter:
    node_selector_key: harbor
    node_selector_value: enabled
  test:
    node_selector_key: harbor
    node_selector_value: enabled
  jobs:
    node_selector_key: harbor
    node_selector_value: enabled
volume:
  class_name: nfs-provisioner
EOF
helm upgrade --wait --install --force demo-rabbitmq --ca-file /workspace/source/temp-ca.crt --version 0.1.2 test/rabbitmq --values /tmp/values.yaml