#!/bin/bash
set -ex

kubectl --kubeconfig /workspace/source/kubeconfig.yaml version
