# run helm test
set -ex
helm test demo-rabbitmq --logs --cleanup --timeout 600