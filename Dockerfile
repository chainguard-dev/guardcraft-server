FROM cgr.dev/chainguard/jre:latest-dev@sha256:1bc70dc6a8d042b57be40d2a5f5841a0f7e112d846a3fbbb6a4aad82ee36b0c2

ARG VERSION="latest"
USER root
RUN apk update && apk add curl libudev jq
RUN adduser --system minecraft
WORKDIR /usr/share/minecraft

COPY build-config.sh server-install.sh /usr/share/minecraft/
RUN chmod +x /usr/share/minecraft/build-config.sh /usr/share/minecraft/server-install.sh
RUN /usr/share/minecraft/server-install.sh ${VERSION}
RUN chown -R minecraft /usr/share/minecraft
USER minecraft

ENTRYPOINT ["/usr/share/minecraft/build-config.sh", "java", "-jar" , "/usr/share/minecraft/server.jar", "nogui"]
