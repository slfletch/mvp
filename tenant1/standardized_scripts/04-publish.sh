#TODO (Stacey)
#!/bin/bash
set -ex
helm fetch test/rabbitmq
#Adding the chart repository to helm
helm push --ca-file /workspace/source/temp-ca.crt --username=admin --password=Harbor12345 ./rabbitmq-0.1.2.tgz nrf