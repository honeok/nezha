# syntax=docker/dockerfile:1
# SPDX-License-Identifier: Apache-2.0
# Copyright (c) 2026 honeok <i@honeok.com>
#
# References:
# https://github.com/nezhahq/nezha

FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS deps
RUN set -ex \
    && apk add --update --no-cache ca-certificates tzdata

FROM golang:1.26-alpine@sha256:0178a641fbb4858c5f1b48e34bdaabe0350a330a1b1149aabd498d0699ff5fb2 AS builder
ARG NEZHA_VERSION=""
WORKDIR /go/src/github.com/nezhahq/nezha
ENV CGO_ENABLED=1
ENV CGO_CFLAGS="-D_LARGEFILE64_SOURCE=1"
RUN set -ex \
    && apk add --update --no-cache bash curl git gcc musl-dev yq-go zstd-static \
    && git clone --depth=1 --branch "$NEZHA_VERSION" https://github.com/nezhahq/nezha.git .
COPY geoip.db pkg/geoip/geoip.db
RUN set -ex \
    && chmod +x ./script/fetch-frontends.sh \
    && ./script/fetch-frontends.sh \
    && go install github.com/swaggo/swag/cmd/swag@latest \
    && swag init --pd -d cmd/dashboard -g main.go -o cmd/dashboard/docs \
    && go mod tidy -v \
    && find /go/pkg/mod/github.com/valyala/gozstd* -name "libzstd_linux_*.a" -exec cp -f /usr/lib/libzstd.a {} \; \
    && go build -v -trimpath -ldflags="-s -w -buildid= \
        -extldflags '-static -fpic' -X 'github.com/nezhahq/nezha/service/singleton.Version=${NEZHA_VERSION#v}' \
        " -o /go/bin/dashboard ./cmd/dashboard

FROM busybox:1.38.0-musl@sha256:8635836765b0c4c43970660219739baa58b0883c2e429e4b8918f7dd1519455c AS dist
LABEL org.opencontainers.image.authors="honeok <i@honeok.com>"
ARG TZ=Asia/Shanghai
WORKDIR /dashboard
COPY --from=deps /etc/ssl/certs /etc/ssl/certs
COPY --from=deps /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /go/bin/dashboard /dashboard/app
COPY --chmod=755 docker-entrypoint.sh /
ENV TZ=$TZ
VOLUME ["/dashboard/data"]
EXPOSE 8008
ENTRYPOINT ["/docker-entrypoint.sh"]
