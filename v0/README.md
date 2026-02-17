# v0

## 自定义Agent监控项目

如果您通过一键脚本安装了Agent，可以通过编辑系统服务配置来添加或修改参数。

编辑文件 `/etc/systemd/system/nezha-agent.service` 并在 `ExecStart=` 行的末尾添加您需要的参数：

- `--report-delay`：设置系统信息上报的间隔时间。默认为 1 秒。为了降低系统资源占用，可以设置为 3（有效范围：1-4 秒）。
- `--skip-conn`：不监控网络连接数。建议在连接数较多或 CPU 资源占用较高的服务器上使用此参数。
- `--skip-procs`：不监控进程数，有助于降低 Agent 的资源占用。
- `--disable-auto-update`：禁用 Agent 的**自动更新**功能，增强安全性。
- `--disable-force-update`：禁用 Agent 的**强制更新**功能，增强安全性。
- `--disable-command-execute`：禁止在 Agent 上执行任何定时任务或使用在线终端，增强安全性。
- `--tls`：启用 SSL/TLS 加密。当您使用 nginx 反向代理 Agent 的 gRPC 连接且 nginx 配置了 SSL/TLS 时，应启用此配置。
- `--use-ipv6-countrycode`：强制使用 IPv6 地址查询国家代码。默认情况下，Agent 使用 IPv4 地址查询国家代码，如果服务器支持 IPv6 且与 IPv4 地址的国家代码不同，可以使用此参数。
- `--gpu`：启用 GPU 监控。注意：GPU 使用率监控可能需要安装额外的依赖包，详细信息可以参考文档。
- `--temperature`：启用硬件温度监控。仅支持的硬件有效，部分 VPS 可能无法获取温度信息。
- `-d` `--debug`：启用调试模式。
- `-u` `--ip-report-period`：本地IP更新间隔, 如果这个值小于 `--report-delay` 设置的值，那么以 `--report-delay` 的值为准。默认为1800秒（30分钟）。
- `-k` `--insecure`：禁用证书检查，适用于使用自签证书的场景。

```shell
--report-delay 3 --skip-conn --skip-procs --disable-auto-update --disable-force-update --disable-command-execute
```

## Agent版本回退

以 `v0.20.5` 为例，替换以下Agent版本执行即可

```shell
case "$(uname -m)" in
x86_64 | amd64)
    SYS_ARCH="amd64"
    ;;
armv8* | arm64 | aarch64)
    SYS_ARCH="arm64"
    ;;
*)
    echo 2>&1 "Arch not supported."
    exit 1
    ;;
esac &&
    curl -Ls -O "https://github.com/nezhahq/agent/releases/download/v0.20.5/nezha-agent_linux_$SYS_ARCH.zip" &&
    unzip -qo "nezha-agent_linux_$SYS_ARCH.zip" -d /opt/nezha/agent &&
    rm -f nezha-agent* &&
    systemctl daemon-reload &&
    systemctl restart nezha-agent.service
```

## 致谢

- https://nezha-v0.mereith.dev
- https://www.nodeseek.com/post-209098-1
- https://www.nodeseek.com/post-211942-1
- https://web.archive.org/web/20240929125721/https://nezha.wiki/guide/dashboard.html
