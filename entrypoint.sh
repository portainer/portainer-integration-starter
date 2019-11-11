#!/bin/bash

service_name="portainer-integration-${PORTAINER_PORT:-9100}"
data_folder="/tmp/integration/${PORTAINER_PORT:-9100}"

echo "Cleanup environment"

docker service rm "${service_name}"

rm -rf "${data_folder}/*"

echo "Copying Portainer data"

cp -rp /tmp/data/* "${data_folder}/"

echo "Deploying Portainer"

docker service create --name ${service_name} \
--network portainer_agent_network \
--publish ${PORTAINER_PORT:-9100}:9000 \
--replicas=1 \
--mount type=bind,src=/${data_folder},dst=/data \
--constraint 'node.role == manager' \
${PORTAINER_IMAGE:-portainerci/portainer:develop} -H "tcp://tasks.agent:9001" --tlsskipverify

exit 0
