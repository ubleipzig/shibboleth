# shibboleth

*shibboleth* is the shibboleth-authenticator as daemon `shibd` which communicates on socket `/var/run/shibboleth/shibd.sock`. This image should be used in connection with the [ubleipzig/httpd] webserver image, which provides the shibboleth-handler als apache2-module.

The base image is [debian:stretch-slim].

## supported Tags

* 2.6-*, 2.6, 2, latest ([2.6/Dockerfile])

## Usage of the Image

This Image is a support image and should be used in connection with [ubleipzig/httpd]. Furthermore it is necessare to set up a service-provider (SP) according to the federation-service where the SP should be used. The image can be used as follows:

```bash
$# docker run --name shibboleth \
  -e SHIB_HOSTNAME=https://www.example.com \
	-e SHIB_SP_ENTITY_ID=my-shibboleth-entity-id \
  ubleipzig/shibboleth

$# docker run --name httpd \
  --volumes-from shibboleth \
  -v /path/to/static/files:/var/www/html \
  -p 80:80 \
  ubleipzig/httpd \
  apache2 -D FOREGROUND -D shibboleth
```

This starts the shibboleth-container and then mounts its volumes via `--volumes-from` into the httpd-container where the requests are handled. Be aware that the images won't work out-of-the-box. There is configuration you have to take care of:

## advanced configuration

* `SHIB_HOSTNAME=https://localhost`: the host-part of the shibboleth-handler. Has to be accessable from the IdP.
* `SHIB_HANDLER_URL=/Shibboleth.sso`: the path-part of the shibboleth-handler. Has to be accessable from the IdP.
* `SHIB_SP_ENTITY_ID=https://hub.docker.com/r/smoebody/dev-dotdeb`: the Entity-ID, which identifies the SP against the IdP (local or federated)
* `SHIB_IDP_ENTITY_ID=""`: the Entity-ID of the IdP which shall be used to log in.
* `SHIB_IDP_DISCOVERY_URL=https://wayf.aai.dfn.de/DFN-AAI-Test/wayf`: the URL of the discovery-service, of which IdP shall be used to log in. Specify either `SHIB_IDP_ENTITY_ID` or this variable.
* `SHIB_ATTRIBUTE_MAP=""`: simple 'name=id'-assignment separated by comma , die als Attribute hinzugefügt werden, z.B. `SHIB_ATTRIBUTE_MAP='foo=urn:1.2.3,bar=urn:1.2.4'`

[ubleipzig/httpd]: https://hub.docker.com/r/ubleipzig/httpd/
[debian:stretch-slim]: https://hub.docker.com/_/debian/
[2.6/Dockerfile]: https://git.sc.uni-leipzig.de/ubl/bdd_dev/docker/shibboleth/blob/master/2.6/Dockerfile
