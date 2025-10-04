# Description: This dockerfile is used to build nezha dashboard v0 with the new geoip database to fix the correct national flag display.
#
# Copyright (c) 2025 honeok <i@honeok.com>
# SPDX-License-Identifier: Apache-2.0
#
# References:
# https://github.com/naiba/nezha

FROM alpine:latest AS depend
LABEL maintainer="honeok <i@honeok.com>"
RUN set -ex \
    && apk add --update --no-cache ca-certificates tzdata

FROM golang:1.25-alpine AS builder
LABEL maintainer="honeok <i@honeok.com>"
ARG NEZHA_VERSION=""
WORKDIR /go/src/github.com/naiba/nezha
ENV CGO_ENABLED=1
ENV CGO_CFLAGS="-D_LARGEFILE64_SOURCE=1"
RUN set -ex \
    && apk add --update --no-cache bash git gcc musl-dev \
    && git clone --depth=1 --branch ${NEZHA_VERSION} https://github.com/nezhahq/nezha.git .
COPY geoip.db pkg/geoip/geoip.db
COPY build.sh .
RUN set -ex \
    && chmod +x build.sh && ./build.sh \
    && go mod tidy -v \
    && go build -v -trimpath -ldflags="\
        -s -w -buildid= \
        -extldflags '-static -fpic' \
        -X 'github.com/naiba/nezha/service/singleton.Version=${NEZHA_VERSION#v}' \
        " -o /go/bin/dashboard ./cmd/dashboard

FROM busybox:stable-musl AS dist
LABEL maintainer="honeok <i@honeok.com>"
ARG TZ=Asia/Shanghai
WORKDIR /dashboard
COPY --from=depend /etc/ssl/certs /etc/ssl/certs
COPY --from=depend /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /go/bin/dashboard /dashboard/app
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN set -ex \
    && chmod +x /docker-entrypoint.sh
ENV TZ=$TZ
VOLUME ["/dashboard/data"]
EXPOSE 80 5555
ENTRYPOINT ["/docker-entrypoint.sh"]
