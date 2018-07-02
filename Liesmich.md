# shibboleth

*shibboleth* ist der Shibboleth-Authenticator, der durch den daemon `shibd` bereitgestellt wird und an Socket `/var/run/shibboleth/shibd.sock` kommuniziert. Das Image sollte zusammen mit dem [ubleipzig/httpd] Webserver-Image verwendet werden, welches den Shibboleth-Listener als Apache2-Modul zur Verfügung stellt.

Das Basis-Image ist [debian:stretch-slim].


## Unterstützte tags

* 2.6-*, 2.6, 2, latest ([2.6/Dockerfile])

## Nutzung des Images

Das Image ist ein Hilfsimage und sollte zusammen mit [ubleipzig/httpd] verwendet werden. Weiterhin ist es notwendig, einen entsprechenden Service-Provider an übergeordneter Stelle einzurichten.

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

Hierbei startet der shibboleth-container und mountet die Volumes via `--volumes-from` in den httpd-container, welcher die Requests entgegennimmt. Bedenke, das dieses Image nicht Out-of-the-Box funktioniert. Es muss entsprechend deiner Umgebung konfiguriert werden:

## erweiterte Konfiguration

* `SHIB_HOSTNAME=https://localhost`: der Host-Teil des Shibboleth-Handlers. Muss vom IdP erreichbar sein.
* `SHIB_HANDLER_URL=/Shibboleth.sso`: der Path-Teil des Shibboleth-Handlers. Muss vom IdP erreichbar sein.
* `SHIB_SP_ENTITY_ID=https://hub.docker.com/r/smoebody/dev-dotdeb`: die Entity-ID, mit der der SP vom IDP identifiziert werden kann (lokal oder Föderation)
* `SHIB_IDP_ENTITY_ID=""`: die Entity-ID des IdP, der zur Anmeldung genutzt werden soll.
* `SHIB_IDP_DISCOVERY_URL=https://wayf.aai.dfn.de/DFN-AAI-Test/wayf`: die URL zum Discovery-Dienst, über den der IdP zur Anmeldung ausgewählt wird. Benutze entweder `SHIB_IDP_ENTITY_ID` oder diese Variable.
* `SHIB_ATTRIBUTE_MAP=""`: simple 'name=id'-Zuweisung mit Komma getrennt, die als Attribute hinzugefügt werden, z.B. `SHIB_ATTRIBUTE_MAP='foo=urn:1.2.3,bar=urn:1.2.4'`

[ubleipzig/httpd]: https://hub.docker.com/r/ubleipzig/httpd/
[debian:stretch-slim]: https://hub.docker.com/_/debian/
[2.6/Dockerfile]: https://git.sc.uni-leipzig.de/ubl/bdd_dev/docker/shibboleth/blob/master/2.6/Dockerfile
