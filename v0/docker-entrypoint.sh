#!/usr/bin/env sh
#
# Copyright 2024 The Nezha Authors. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

printf "nameserver 127.0.0.11\nnameserver 8.8.4.4\nnameserver 223.5.5.5\n" >/etc/resolv.conf
exec /dashboard/app
