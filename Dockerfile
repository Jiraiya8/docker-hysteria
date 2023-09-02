FROM --platform=$TARGETPLATFORM alpine:latest AS builder

ARG TARGETOS

ARG TARGETARCH

RUN set -ex \
    && apk update \
    && apk add wget \
    && wget https://github.com/apernet/hysteria/releases/latest/download/hysteria-${TARGETOS}-${TARGETARCH} -O /usr/local/bin/hysteria

FROM --platform=$TARGETPLATFORM alpine:latest AS dist

COPY --from=builder /usr/local/bin/hysteria /usr/local/bin/

RUN set -ex \
    && chmod +x /usr/local/bin/hysteria \
    && apk update \
    && apk upgrade \
    && apk add tzdata ca-certificates \
    && rm -rf /var/cache/apk/*

VOLUME [ "/etc/hysteria/" ]

EXPOSE 443

ENTRYPOINT [ "/usr/local/bin/hysteria" ]

CMD [ "help" ]

