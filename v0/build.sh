#!/usr/bin/env bash
#
# Description: This script is used to replace the unpkg and bytedance static resource public library address.
#
# Copyright (c) 2025 honeok <i@honeok.com>
# SPDX-License-Identifier: Apache-2.0

set -eEux

# common
sed -i 's#https://unpkg.com/jquery@3.7.1/dist/jquery.min.js#https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js#g' resource/template/common/footer.html
sed -i 's#https://unpkg.com/semantic-ui@2.4.0/dist/semantic.min.js#https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.0/semantic.min.js#g' resource/template/common/footer.html
sed -i 's#https://unpkg.com/vue@2.6.14/dist/vue.min.js#https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.14/vue.min.js#g' resource/template/common/footer.html

sed -i 's#https://unpkg.com/semantic-ui@2.4.0/dist/semantic.min.css#https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.0/semantic.min.css#g' resource/template/common/header.html
sed -i 's#https://unpkg.com/font-logos@0.17.0/assets/font-logos.css#https://cdnjs.cloudflare.com/ajax/libs/font-logos/0.17/font-logos.css#g' resource/template/common/header.html

# dashboard-default
if [ -f resource/template/dashboard-default/file.html ]; then
    MDUI_VERSION="$(wget -qO- https://api.cdnjs.com/libraries/mdui | sed -n 's/.*"version": *"\([^"]*\)".*/\1/p')"
    sed -i "s#https://unpkg.com/mdui@2/mdui.css#https://cdnjs.cloudflare.com/ajax/libs/mdui/$MDUI_VERSION/mdui.css#g" resource/template/dashboard-default/file.html
    sed -i "s#https://unpkg.com/mdui@2/mdui.global.js#https://cdnjs.cloudflare.com/ajax/libs/mdui/$MDUI_VERSION/mdui.global.js#g" resource/template/dashboard-default/file.html
fi

sed -i 's#https://unpkg.com/clipboard@2.0.11/dist/clipboard.min.js#https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.11/clipboard.min.js#g' resource/template/dashboard-default/server.html

sed -i 's#https://unpkg.com/xterm@5.3.0/css/xterm.css#https://registry.npmmirror.com/xterm/5.3.0/files/css/xterm.css#g' resource/template/dashboard-default/terminal.html
sed -i 's#https://unpkg.com/xterm@5.3.0/lib/xterm.js#https://registry.npmmirror.com/xterm/5.3.0/files/lib/xterm.js#g' resource/template/dashboard-default/terminal.html
sed -i 's#https://unpkg.com/@xterm/addon-fit@0.10.0/lib/addon-fit.js#https://registry.npmmirror.com/@xterm/addon-fit/0.10.0/files/lib/addon-fit.js#g' resource/template/dashboard-default/terminal.html
sed -i 's#https://unpkg.com/@xterm/addon-web-links@0.11.0/lib/addon-web-links.js#https://registry.npmmirror.com/@xterm/addon-web-links/0.11.0/files/lib/addon-web-links.js#g' resource/template/dashboard-default/terminal.html
sed -i 's#https://unpkg.com/@xterm/addon-attach@0.11.0/lib/addon-attach.js#https://registry.npmmirror.com/@xterm/addon-attach/0.11.0/files/lib/addon-attach.js#g' resource/template/dashboard-default/terminal.html

# theme-angel-kanade
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/jquery/3.6.0/jquery.min.js#https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js#g' resource/template/theme-angel-kanade/footer.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/semantic-ui/2.4.1/semantic.min.js#https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js#g' resource/template/theme-angel-kanade/footer.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/vue/2.6.14/vue.min.js#https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.14/vue.min.js#g' resource/template/theme-angel-kanade/footer.html

sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/semantic-ui/2.4.1/semantic.min.css#https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css#g' resource/template/theme-angel-kanade/header.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/font-logos/0.17/font-logos.min.css#https://cdnjs.cloudflare.com/ajax/libs/font-logos/0.17/font-logos.min.css#g' resource/template/theme-angel-kanade/header.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css#https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css#g' resource/template/theme-angel-kanade/header.html

sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/flag-icon-css/4.1.5/flags/1x1/#https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/4.1.5/flags/1x1/#g' resource/template/theme-angel-kanade/home.html

# theme-daynight
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/font-awesome/6.0.0/css/all.min.css#https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css#g' resource/template/theme-daynight/home.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/jquery/3.6.0/jquery.min.js#https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js#g' resource/template/theme-daynight/home.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/vue/2.6.14/vue.min.js#https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.14/vue.min.js#g' resource/template/theme-daynight/home.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/limonte-sweetalert2/11.4.4/sweetalert2.all.min.js#https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.4.4/sweetalert2.all.min.js#g' resource/template/theme-daynight/home.html

sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/font-awesome/6.0.0/css/all.min.css#https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css#g' resource/template/theme-daynight/network.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/jquery/3.6.0/jquery.min.js#https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js#g' resource/template/theme-daynight/network.html
sed -i 's#https://lf26-cdn-tos.bytecdntp.com/cdn/expire-1-M/echarts/5.3.0-rc.1/echarts.min.js#https://cdnjs.cloudflare.com/ajax/libs/echarts/5.3.0-rc.1/echarts.min.js#g' resource/template/theme-daynight/network.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/vue/2.6.14/vue.min.js#https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.14/vue.min.js#g' resource/template/theme-daynight/network.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/limonte-sweetalert2/11.4.4/sweetalert2.all.min.js#https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.4.4/sweetalert2.all.min.js#g' resource/template/theme-daynight/network.html

sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/mdui/1.0.2/css/mdui.min.css#https://cdnjs.cloudflare.com/ajax/libs/mdui/1.0.2/css/mdui.min.css#g' resource/template/theme-daynight/service.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/font-awesome/6.0.0/css/all.min.css#https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css#g' resource/template/theme-daynight/service.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/jquery/3.6.0/jquery.min.js#https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js#g' resource/template/theme-daynight/service.html

# theme-default
sed -i 's#https://unpkg.com/semantic-ui@2.4.0/dist/semantic.min.css#https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.0/semantic.min.css#g' resource/template/theme-default/header.html
sed -i 's#https://unpkg.com/font-logos@0.17.0/assets/font-logos.css#https://cdnjs.cloudflare.com/ajax/libs/font-logos/0.17/font-logos.css#g' resource/template/theme-default/header.html
sed -i 's#https://unpkg.com/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css#https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css#g' resource/template/theme-default/header.html
sed -i 's#https://unpkg.com/flag-icons@7.2.3/css/flag-icons.min.css#https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/7.2.3/css/flag-icons.min.css#g' resource/template/theme-default/header.html
sed -i 's#https://unpkg.com/jquery@3.7.1/dist/jquery.min.js#https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js#g' resource/template/theme-default/header.html
sed -i 's#https://unpkg.com/semantic-ui@2.4.0/dist/semantic.min.js#https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.0/semantic.min.js#g' resource/template/theme-default/header.html
sed -i 's#https://unpkg.com/vue@2.6.14/dist/vue.min.js#https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.14/vue.min.js#g' resource/template/theme-default/header.html
sed -i 's#https://unpkg.com/echarts@5.5.0/dist/echarts.min.js#https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js#g' resource/template/theme-default/header.html

# theme-hotaru
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/semantic-ui/2.4.1/semantic.min.css#https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css#g' resource/template/theme-hotaru/home.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/font-awesome/6.0.0/css/all.min.css#https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css#g' resource/template/theme-hotaru/home.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/jquery/3.6.0/jquery.min.js#https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js#g' resource/template/theme-hotaru/home.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/semantic-ui/2.4.1/semantic.min.js#https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js#g' resource/template/theme-hotaru/home.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/vue/2.6.14/vue.min.js#https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.14/vue.min.js#g' resource/template/theme-hotaru/home.html

# theme-mdui
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/mdui/1.0.2/css/mdui.min.css#https://cdnjs.cloudflare.com/ajax/libs/mdui/1.0.2/css/mdui.min.css#g' resource/template/theme-mdui/home.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/flag-icon-css/4.1.5/flags/1x1/#https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/4.1.5/flags/1x1/#g' resource/template/theme-mdui/home.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/mdui/1.0.2/js/mdui.min.js#https://cdnjs.cloudflare.com/ajax/libs/mdui/1.0.2/js/mdui.min.js#g' resource/template/theme-mdui/home.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/jquery/3.6.0/jquery.min.js#https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js#g' resource/template/theme-mdui/home.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/vue/2.6.14/vue.min.js#https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.14/vue.min.js#g' resource/template/theme-mdui/home.html

sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/mdui/1.0.2/css/mdui.min.css#https://cdnjs.cloudflare.com/ajax/libs/mdui/1.0.2/css/mdui.min.css#g' resource/template/theme-mdui/network.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/flag-icon-css/4.1.5/flags/4x3/#https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/4.1.5/flags/4x3/#g' resource/template/theme-mdui/network.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/mdui/1.0.2/js/mdui.min.js#https://cdnjs.cloudflare.com/ajax/libs/mdui/1.0.2/js/mdui.min.js#g' resource/template/theme-mdui/network.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/jquery/3.6.0/jquery.min.js#https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js#g' resource/template/theme-mdui/network.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/vue/2.6.14/vue.min.js#https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.14/vue.min.js#g' resource/template/theme-mdui/network.html
sed -i 's#https://lf26-cdn-tos.bytecdntp.com/cdn/expire-1-M/echarts/5.3.0-rc.1/echarts.min.js#https://cdnjs.cloudflare.com/ajax/libs/echarts/5.3.0-rc.1/echarts.min.js#g' resource/template/theme-mdui/network.html

sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/mdui/1.0.2/css/mdui.min.css#https://cdnjs.cloudflare.com/ajax/libs/mdui/1.0.2/css/mdui.min.css#g' resource/template/theme-mdui/service.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/mdui/1.0.2/js/mdui.min.js#https://cdnjs.cloudflare.com/ajax/libs/mdui/1.0.2/js/mdui.min.js#g' resource/template/theme-mdui/service.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/jquery/3.6.0/jquery.min.js#https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js#g' resource/template/theme-mdui/service.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/vue/2.6.14/vue.min.js#https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.14/vue.min.js#g' resource/template/theme-mdui/service.html

sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/mdui/1.0.2/css/mdui.min.css#https://cdnjs.cloudflare.com/ajax/libs/mdui/1.0.2/css/mdui.min.css#g' resource/template/theme-mdui/viewpassword.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/mdui/1.0.2/js/mdui.min.js#https://cdnjs.cloudflare.com/ajax/libs/mdui/1.0.2/js/mdui.min.js#g' resource/template/theme-mdui/viewpassword.html
sed -i 's#https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-y/jquery/3.6.0/jquery.min.js#https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js#g' resource/template/theme-mdui/viewpassword.html

# theme-server-status
sed -i 's#https://unpkg.com/bootstrap@3.4.1/dist/css/bootstrap.min.css#https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap.min.css#g' resource/template/theme-server-status/header.html
sed -i 's#https://unpkg.com/bootstrap@3.4.1/dist/css/bootstrap-theme.min.css#https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap-theme.min.css#g' resource/template/theme-server-status/header.html
sed -i 's#https://unpkg.com/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css#https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css#g' resource/template/theme-server-status/header.html
sed -i 's#https://unpkg.com/font-logos@0.17.0/assets/font-logos.css#https://cdnjs.cloudflare.com/ajax/libs/font-logos/0.17/font-logos.css#g' resource/template/theme-server-status/header.html
sed -i 's#https://unpkg.com/flag-icons@7.2.3/css/flag-icons.min.css#https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/7.2.3/css/flag-icons.min.css#g' resource/template/theme-server-status/header.html
sed -i 's#https://unpkg.com/semantic-ui@2.4.0/dist/semantic.min.css#https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.0/semantic.min.css#g' resource/template/theme-server-status/header.html
sed -i 's#https://unpkg.com/jquery@3.7.1/dist/jquery.min.js#https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js#g' resource/template/theme-server-status/header.html
sed -i 's#https://unpkg.com/bootstrap@3.4.1/dist/js/bootstrap.min.js#https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js#g' resource/template/theme-server-status/header.html
sed -i 's#https://unpkg.com/vue@2.6.14/dist/vue.min.js#https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.14/vue.min.js#g' resource/template/theme-server-status/header.html
sed -i 's#https://unpkg.com/echarts@5.5.0/dist/echarts.min.js#https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js#g' resource/template/theme-server-status/header.html
