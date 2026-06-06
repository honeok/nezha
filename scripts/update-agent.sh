#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
#
# Description: The script is used to update the Nezha Agent core and restart the service.
# Copyright (c) 2026 honeok <i@honeok.com>

set -eE

# 各变量默认值
TEMP_DIR="$(mktemp -d 2> /dev/null)"
GITHUB_REPO="nezhahq/agent"
GITHUB_PROXY="https://v6.gh-proxy.org/"
CORE_DIR="/opt/nezha/agent"
CORE_NAME="nezha-agent"

# 终止信号捕获
trap 'rm -rf "${TEMP_DIR:?}" > /dev/null 2>&1' INT TERM EXIT

cd "$TEMP_DIR" > /dev/null 2>&1 || exit 1

check_root() {
    if [ "$EUID" -ne 0 ] || [ "$(id -ru)" -ne 0 ]; then
        exit 1
    fi
}

curl() {
    local rc

    # 添加 --fail 不然404退出码也为0
    # 32位cygwin已停止更新, 证书可能有问题, 添加 --insecure
    # centos7 curl 不支持 --retry-connrefused --retry-all-errors 因此手动 retry
    for ((i = 1; i <= 5; i++)); do
        command curl --connect-timeout 10 --fail --insecure "$@"
        rc="$?"
        if [ "$rc" -eq 0 ]; then
            return
        else
            # 403 404 错误或达到重试次数
            if [ "$rc" -eq 22 ] || [ "$i" -eq 5 ]; then
                return "$rc"
            fi
            sleep 0.5
        fi
    done
}

is_darwin() {
    [ "$(uname -s 2> /dev/null)" = "Darwin" ]
}

is_linux() {
    [ "$(uname -s 2> /dev/null)" = "Linux" ]
}

is_in_china() {
    if [ -z "$COUNTRY" ]; then
        # www.prologis.cn
        # www.autodesk.com.cn
        # www.keysight.com.cn
        if ! COUNTRY="$(curl -L http://www.qualcomm.cn/cdn-cgi/trace | grep '^loc=' | cut -d= -f2 | grep .)"; then
            exit 1
        fi
        echo >&2 "Location: $COUNTRY"
    fi
    [ "$COUNTRY" = CN ]
}

has_ipv4() {
    ip -4 route get 151.101.65.1 > /dev/null 2>&1
}

has_ipv6() {
    ip -6 route get 2a04:4e42:200::485 > /dev/null 2>&1
}

check_sys() {
    if is_linux; then
        OS_NAME="linux"
    elif is_darwin; then
        OS_NAME="darwin"
    else
        exit 1
    fi
}

check_arch() {
    case "$(uname -m 2> /dev/null)" in
    386 | i*86) OS_ARCH="386" ;;
    amd64 | x86_64) OS_ARCH="amd64" ;;
    arm64 | armv8 | aarch64) OS_ARCH="arm64" ;;
    riscv64) OS_ARCH="riscv64" ;;
    s390x) OS_ARCH="s390x" ;;
    *) exit 1 ;;
    esac
}

check_cdn() {
    if is_in_china; then
        return
    elif ! has_ipv4 && has_ipv6; then
        return
    else
        GITHUB_PROXY=""
    fi
}

# 更新内核
update_core() {
    local latest_ver current_ver

    for ((i = 1; i <= 5; i++)); do
        latest_ver="$(curl -Ls "${GITHUB_PROXY}https://api.github.com/repos/$GITHUB_REPO/releases" | sed -n 's/.*"tag_name": *"v\([^"]*\)".*/\1/p' | sort -rV | head -n 1)"
        if grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+' <<< "$latest_ver"; then
            break
        fi
        sleep 0.5
    done
    current_ver="$(eval "$CORE_DIR/$CORE_NAME" -v | awk '{print $3}')"

    if [[ "$(printf '%s\n%s\n' "$latest_ver" "$current_ver" | sort -V | head -n1)" == "$latest_ver" ]]; then
        return
    fi

    curl -L -O "${GITHUB_PROXY}https://github.com/$GITHUB_REPO/releases/download/v$latest_ver/${CORE_NAME}_${OS_NAME}_${OS_ARCH}.zip"
    curl -L -O "${GITHUB_PROXY}https://github.com/$GITHUB_REPO/releases/download/v$latest_ver/checksums.txt"
    grep "${CORE_NAME}_${OS_NAME}_${OS_ARCH}.zip" checksums.txt | sha256sum -c - > /dev/null 2>&1

    unzip -qo "${CORE_NAME}_${OS_NAME}_${OS_ARCH}.zip" -d "$CORE_DIR"
    chmod +x "$CORE_DIR/$CORE_NAME" > /dev/null 2>&1
}

restart_core() {
    local restart_cmd

    # shellcheck disable=SC1091
    . /etc/os-release

    if [ "$ID" = "alpine" ] || [ "$ID" = "immortalwrt" ] || [ "$ID" = "openwrt" ]; then
        restart_cmd="/etc/init.d/$CORE_NAME restart"
    else
        restart_cmd="systemctl restart $CORE_NAME.service --quiet"
    fi

    for ((i = 1; i <= 3; i++)); do
        if eval "$restart_cmd" > /dev/null 2>&1; then
            return
        fi
        if [ "$i" -lt 3 ]; then
            sleep 1
        fi
    done

    exit 1
}

check_root
check_sys
check_arch
check_cdn
update_core
restart_core
