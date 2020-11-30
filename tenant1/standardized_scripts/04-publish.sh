#TODO (Stacey)
#!/bin/bash
set -ex
kubectl get -n harbor secrets harbor-release-harbor-nginx -o 'go-template={{ index .data "ca.crt" | base64decode }}' > ./temp-ca.crt
tail -f /dev/null
#Adding the chart repository to helm
helm push --ca-file temp-ca.crt --username=admin --password=Harbor12345 ./rabbitmq-0.1.2.tgz nrf