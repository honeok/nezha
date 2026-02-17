# syntax=docker/dockerfile:1
# SPDX-License-Identifier: Apache-2.0
# Copyright (c) 2025-2026 honeok <i@honeok.com>
#
# References:
# https://github.com/naiba/nezha

FROM alpine:latest AS deps
RUN set -ex \
    && apk add --update --no-cache ca-certificates tzdata

FROM golang:1.26-alpine AS builder
ARG NEZHA_VERSION=""
WORKDIR /go/src/github.com/naiba/nezha
ENV CGO_ENABLED=1
ENV CGO_CFLAGS="-D_LARGEFILE64_SOURCE=1"
RUN set -ex \
    && apk add --update --no-cache bash git gcc musl-dev \
    && git clone --depth=1 --branch "$NEZHA_VERSION" https://github.com/nezhahq/nezha.git .
COPY geoip.db pkg/geoip/geoip.db
COPY --chmod=755 replace.sh .
RUN set -ex \
    && ./replace.sh \
    && go mod tidy -v \
    && go build -v -trimpath -ldflags="-s -w -buildid= \
        -extldflags '-static -fpic' -X 'github.com/naiba/nezha/service/singleton.Version=${NEZHA_VERSION#v}' \
        " -o /go/bin/dashboard ./cmd/dashboard

FROM busybox:stable-musl AS dist
LABEL org.opencontainers.image.authors="honeok <i@honeok.com>"
ARG TZ=Asia/Shanghai
WORKDIR /dashboard
COPY --from=deps /etc/ssl/certs /etc/ssl/certs
COPY --from=deps /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /go/bin/dashboard /dashboard/app
COPY --chmod=755 docker-entrypoint.sh /
ENV TZ=$TZ
VOLUME ["/dashboard/data"]
EXPOSE 80 5555
ENTRYPOINT ["/docker-entrypoint.sh"]
