#!/bin/bash
set -ex
helm delete --purge demo-rabbitmq
#TODO helm delete --purge previous helm deployment
helm list