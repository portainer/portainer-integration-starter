#!/bin/bash

echo "Cleanup environment"

docker service rm integration_portainer-${PORTAINER_PORT:-9100}

rm -rf /tmp/integration/*

echo "Copying Portainer data"

cp -rp /tmp/data/* /tmp/integration/

echo "Deploying Portainer"

docker service create --name integration_portainer-${PORTAINER_PORT:-9100} \
--network portainer_agent_network \
--publish ${PORTAINER_PORT:-9100}:9000 \
--replicas=1 \
--mount type=bind,src=//tmp/integration,dst=/data \
--constraint 'node.role == manager' \
${PORTAINER_IMAGE:-portainerci/portainer:develop} -H "tcp://tasks.agent:9001" --tlsskipverify

exit 0
