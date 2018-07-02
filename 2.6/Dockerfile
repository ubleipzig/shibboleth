FROM debian:stretch-slim
ENTRYPOINT [ "/docker-entrypoint" ]
CMD ["shibd", "-u", "_shibd", "-g", "_shibd", "-F"]

ENV SHIB_HOSTNAME=https://localhost \
	SHIB_HANDLER_URL=/Shibboleth.sso \
	SHIB_SP_ENTITY_ID=https://hub.docker.com/r/smoebody/dev-dotdeb \
	SHIB_IDP_DISCOVERY_URL=https://wayf.aai.dfn.de/DFN-AAI-Test/wayf \
	SHIB_ATTRIBUTE_MAP=""

ADD assets/docker-entrypoint /docker-entrypoint

ADD assets/*.pem /etc/shibboleth/

RUN chmod a+x /docker-entrypoint \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends shibboleth-sp2-utils \
	&& rm -r /var/lib/apt/lists/*

VOLUME ["/etc/shibboleth", "/run/shibboleth"]
