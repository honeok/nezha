# syntax=docker/dockerfile:1
# SPDX-License-Identifier: Apache-2.0
# Copyright (c) 2025-2026 honeok <i@honeok.com>
#
# References:
# https://github.com/nezhahq/nezha

FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS deps
RUN set -ex \
    && apk add --update --no-cache ca-certificates tzdata

FROM golang:1.27-alpine@sha256:26402d86be3d72e6a9410afa0108f03529f51f0c1b5eb7f503d0bc44cc7857ac AS builder
ARG NEZHA_VERSION=""
WORKDIR /go/src/github.com/nezhahq/nezha
ENV CGO_ENABLED=1
ENV CGO_CFLAGS="-D_LARGEFILE64_SOURCE=1"
RUN set -ex \
    && apk add --update --no-cache bash curl git gcc musl-dev yq-go \
    && git clone --depth=1 --branch "$NEZHA_VERSION" https://github.com/nezhahq/nezha.git .
COPY geoip.db pkg/geoip/geoip.db
RUN set -ex \
    && chmod +x ./script/fetch-frontends.sh \
    && ./script/fetch-frontends.sh \
    && go install github.com/swaggo/swag/cmd/swag@latest \
    && swag init --pd -d . -g ./cmd/dashboard/main.go -o ./cmd/dashboard/docs --parseGoList=false \
    && go mod tidy -v \
    && go build -v -trimpath -ldflags="-s -w -buildid= \
        -extldflags '-static -fpic' -X 'github.com/nezhahq/nezha/service/singleton.Version=${NEZHA_VERSION#v}' \
        " -o /go/bin/dashboard ./cmd/dashboard

FROM busybox:1.38.0-musl@sha256:32b5cdad7cce41dfd53d0ae06baebcf8357a147ee7694dc706911c373bc30c37 AS dist
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
