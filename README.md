# portainer-integration-starter

Run a Portainer environment based on another environment data.

```
docker run -v /path/to/existing/data:/tmp/data -v /tmp/integration:/tmp/integration -v /var/run/docker.sock:/var/run/docker.sock -e PORTAINER_IMAGE="portainerci/portainer:hotfix-1.22.2" portainer/integration-starter
```

The `PORTAINER_IMAGE` environment variable is optional and default to `portainerci/portainer:develop`.

The new Portainer instance will be available on the same host under port 9100 by default (can be changed via `PORTAINER_PORT` env var).

The port associated to the Edge server can be changed via `PORTAINER_EDGE_PORT` env var and defaults to 10000.
