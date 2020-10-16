# run helm test
#!/bin/bash
set -ex
helm test demo-rabbitmq --logs --cleanup --timeout 600