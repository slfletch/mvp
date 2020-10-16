#TODO (Stacey)
kubectl get -n harbor secrets harbor-harbor-harbor-nginx -o 'go-template={{ index .data "ca.crt" | base64decode }}' > ./temp-ca.crt

#Adding the chart repository to helm

helm plugin install https://github.com/chartmuseum/helm-push
helm push --ca-file harbor-ca.crt --username=admin --password=Harbor12345 ./rabbitmq-0.1.0.tgz tenent0