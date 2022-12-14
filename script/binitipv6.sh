#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
WORKDIR=/workdir
HOSTNAME=OpenWrt
IPADDRESS=192.168.8.1
SSID=Sirpdboy
ENCRYPTION=psk2
KEY=123456
git clone https://github.com/sirpdboy/build.git ./package/build
git clone https://github.com/loso3000/other ./package/other

git clone https://github.com/sirpdboy/sirpdboy-package ./package/diy
# rm -rf ./package/lean/r8152
rm -rf ./feeds/luci/themes/luci-theme-argon
rm -rf ./feeds/luci/applications/luci-app-wrtbwmon

# rm -rf ./package/cupsd/luci-app-cupsd
rm -rf ./feeds/packages/utils/cupsd
rm -rf ./feeds/packages/utils/cups-bjnp
rm -rf ./feeds/luci/applications/luci-app-cupsd
# svn export https://github.com/immortalwrt/packages/branches/openwrt-18.06/utils/cupsd ./package/build/cupsd
# svn export https://github.com/immortalwrt/packages/branches/openwrt-18.06/utils/cups-bjnp./package/build/cups-bjnp 
# svn export https://github.com/immortalwrt/luci/branches/openwrt-18.06-k5.4/applications/luci-app-cupsd ./package/cupsd/luci-app-cupsd

# Add ddnsto & linkease
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/ ./package/diy1/luci
svn co https://github.com/linkease/nas-packages/trunk/network/services/ ./package/diy1/linkease
svn co https://github.com/linkease/istore/trunk/luci/ ./package/diy1/istore
sed -i 's/1/0/g' ./package/diy1/linkease/linkease/files/linkease.config
sed -i 's/luci-lib-ipkg/luci-base/g' package/diy1/istore/luci-app-store/Makefile

# rm -rf package/diy1/luci-app-store
# rm -rf ./package/diy1/luci/luci-app-istorex
# rm -rf package/diy1/luci/luci-app-quickstart

rm -rf ./feeds/packages/net/mosdns
svn co https://github.com/QiuSimons/openwrt-mos/trunk/ package/mosdns
sed -i "/filter_aaaa='1'/d" package/mosdns/luci-app-mosdns/root/etc/init.d/mosdns

#upnp
# rm -rf ./feeds/packages/net/miniupnp
# rm -rf ./feeds/luci/applications/luci-app-upnp
rm -rf  ./package/diy/upnpd


rm -rf ./package/diy/luci-lib-ipkg
# rm -rf ./package/other/up/luci-app-https-dns-proxy
rm -rf ./package/other/up/https-dns-proxy
# rm -rf ./feeds/luci/applications/luci-app-https-dns-proxy
# rm -rf ./feeds/packages/net/https-dns-proxy
# svn export https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy feeds/packages/net/https-dns-proxy
# svn export https://github.com/immortalwrt/luci/branches/openwrt-18.06-k5.4/applications/luci-app-https-dns-proxy ./package/build/luci-app-https-dns-proxy
# svn export https://github.com/immortalwrt/packages/branches/openwrt-18.06/net/https-dns-proxy ./package/build/https-dns-proxy

# git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/diy/OpenAppFilter
#coremark
cp -f ./package/build/set/coremark.sh feeds/packages/utils/coremark/

git clone https://github.com/sbwml/openwrt-alist.git package/openwrt-alist
sed -i 's/????????????/??????/g' ./package/openwrt-alist/luci-app-alist/po/zh-cn/alist.po

echo '??????smartdns'
rm -rf ./feeds/packages/net/smartdns
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns ./feeds/packages/net/smartdns

# netdata 
# rm -rf  ./package/diy/netdata
cp -rf ./feeds/packages/admin/netdata ./package/diy/
rm -rf ./feeds/luci/applications/luci-app-netdata
# rm -rf ./feeds/packages/admin/netdata
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata ./feeds/luci/applications/luci-app-netdata
# rm -rf ./feeds/packages/admin/netdata && svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata ./feeds/packages/admin/netdata

cat  ./package/build/mwan3/files/etc/config/mwan3   > ./feeds/packages/net/mwan3/files/etc/config/mwan3 && rm -rf ./package/build/mwan3
# sed -i 's,+mwan3,+mwan3plus,g' ./feeds/luci/applications/luci-app-mwan3/Makefile
# curl -fsSL  https://raw.githubusercontent.com/sirpdboy/build/master/mwan3/files/etc/config/mwan3   > ./feeds/packages/net/mwan3/files/etc/config/mwan3
# rm -rf ./feeds/packages/net/mwan3 && svn co https://github.com/sirpdboy/build/trunk/mwan3 ./feeds/packages/net/mwan3

# rm -rf ./feeds/packages/devel/ninja   && svn co https://github.com/Lienol/openwrt-packages/trunk/devel/ninja feeds/packages/devel/ninja
# rm -rf ./package/lean/autosamba
# rm -rf ./feeds/luci/applications/luci-app-accesscontrol

rm -rf ./package/build/autocore
rm -rf ./package/build/default-settings

rm -rf ./package/build/automount
rm -rf ./package/lean/automount  && svn co https://github.com/sirpdboy/build/trunk/automount ./package/lean/automount
rm -rf ./package/lean/autocore  && svn co https://github.com/sirpdboy/build/trunk/autocore ./package/lean/autocore
rm -rf ./package/lean/default-settings  && svn co https://github.com/sirpdboy/build/trunk/default-settings ./package/lean/default-settings

rm -rf ./package/build/luci-app-arpbind
rm -rf ./feeds/luci/applications/luci-app-arpbind
# svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-arpbind feeds/luci/applications/luci-app-arpbind
svn co https://github.com/sirpdboy/build/trunk/luci-app-arpbind ./feeds/luci/applications/luci-app-arpbind 
ln -sf ../../../feeds/luci/applications/luci-app-arpbind ./package/feeds/luci/luci-app-arpbind

rm -rf ./feeds/luci/applications/luci-app-dockerman
rm -rf ./feeds/luci/applications/luci-app-docker
# rm -rf ./package/diy/luci-app-dockerman
# rm -rf ./feeds/packages/utils/docker
# Add luci-app-dockerman
rm -rf ./feeds/luci/collections/luci-lib-docker
git clone --depth=1 https://github.com/lisaac/luci-lib-docker ./package/lean/luci-lib-docker
sed -i '/auto_start/d' ./package/diy/luci-app-dockerman/root/etc/uci-defaults/luci-app-dockerman
sed -i '/sysctl.d/d' feeds/packages/utils/dockerd/Makefile
sed -i 's,# CONFIG_BLK_CGROUP_IOCOST is not set,CONFIG_BLK_CGROUP_IOCOST=y,g' target/linux/generic/config-5.10
# sed -i 's,# CONFIG_BLK_CGROUP_IOCOST is not set,CONFIG_BLK_CGROUP_IOCOST=y,g' target/linux/generic/config-5.15

#docker err
#rm -rf ./feeds/packages/utils/runc/Makefile
#svn export https://github.com/openwrt/packages/trunk/utils/runc/Makefile ./feeds/packages/utils/runc/Makefile

#rm -rf ./feeds/luci/applications/luci-app-vlmcsd
#rm -rf ./feeds/luci/applications/vlmcsd
ln -sf ../../../feeds/packages/net/vlmcsd ./package/feeds/packages/vlmcsd 
ln -sf ../../../feeds/luci/applications/luci-app-vlmcsd ./feeds/luci/applications/luci-app-vlmcsd


# Add luci-aliyundrive-webdav
rm -rf ./feeds/luci/applications/luci-app-aliyundrive-webdav 
rm -rf ./feeds/luci/applications/aliyundrive-webdav
svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav ./feeds/luci/applications/aliyundrive-webdav
svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav ./feeds/luci/applications/luci-app-aliyundrive-webdav 

#syncdial
# rm -rf luci-app-syncdial  && git clone https://github.com/rufengsuixing/luci-app-syncdial.git feeds/luci/applications/luci-app-syncdial  #IPV6??????

# samba4
rm -rf ./feeds/luci/applications/luci-app-samba4 &&svn co https://github.com/sirpdboy/build/trunk/luci-app-samba4 ./feeds/luci/applications/luci-app-samba4

git clone --depth 1 https://github.com/zxlhhyccc/luci-app-v2raya.git package/new/luci-app-v2raya
svn co https://github.com/v2rayA/v2raya-openwrt/trunk/v2raya package/new/v2raya

# curl -fsSL  https://raw.githubusercontent.com/sirpdboy/sirpdboy-package/master/set/sysctl.conf > ./package/base-files/files/etc/sysctl.conf
echo '????????????'
curl -fsSL  https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

sed -i 's/????????????/??????/g' ./feeds/luci/applications/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/Turbo ACC ????????????/ACC????????????/g' ./feeds/luci/applications/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/Turbo ACC ????????????/ACC????????????/g' ./feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po
sed -i 's/Turbo ACC ????????????/ACC????????????/g' ./feeds/luci/applications/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/???????????????????????????/??????????????????/g' ./feeds/luci/applications/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
sed -i 's/?????????//g' ./feeds/luci/applications/luci-app-familycloud/luasrc/controller/familycloud.lua
sed -i 's/??????????????????/??????/g' ./feeds/luci/applications/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
sed -i 's/KMS ?????????/KMS??????/g' ./feeds/luci/applications/luci-app-vlmcsd/po/zh-cn/vlmcsd.po
sed -i 's/USB ???????????????"/????????????/g' ./feeds/luci/applications/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/????????????/??????/g' ./feeds/luci/applications/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/aMule??????/????????????/g' ./feeds/luci/applications/luci-app-amule/po/zh-cn/amule.po
sed -i 's/????????????/??????/g' ./feeds/luci/applications/luci-app-amule/po/zh-cn/amule.po
sed -i 's/????????????/???????????? ?????????admin??????adminadmin/g' ./feeds/luci/applications/luci-app-qbittorrent/po/zh-cn/qbittorrent.po
sed -i 's/????????????/??????/g' ./feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/a.default = "0"/a.default = "1"/g' ./feeds/luci/applications/luci-app-cifsd/luasrc/controller/cifsd.lua   #?????????
echo  "        option tls_enable 'true'" >> ./feeds/luci/applications/luci-app-frpc/root/etc/config/frp   #FRP????????????
sed -i 's/invalid/# invalid/g' ./package/network/services/samba36/files/smb.conf.template  #????????????
sed -i '/mcsub_renew.datatype/d'  ./feeds/luci/applications/luci-app-udpxy/luasrc/model/cbi/udpxy.lua  #??????UDPXY????????????55?????????

rm -rf ./feeds/luci/applications/luci-app-socat && svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-socat ./feeds/luci/applications/luci-app-socat
sed -i 's/msgstr "Socat"/msgstr "????????????"/g' ./feeds/luci/applications/luci-app-socat/po/zh-cn/socat.po
ln -sf ../../../feeds/luci/applications/luci-app-socat ./package/feeds/luci/luci-app-socat

sed -i '/filter_/d' ./package/network/services/dnsmasq/files/dhcp.conf   #DHCP??????IPV6??????
sed -i 's/??????????????????????????????/????????????!?????????????????????~/g' ./feeds/luci/modules/luci-base/po/zh-cn/base.po   #???????????????
echo '????????????'
rm -rf ./feeds/luci/applications/luci-app-unblockmusic
git clone https://github.com/immortalwrt/luci-app-unblockneteasemusic.git  ./package/diy/luci-app-unblockneteasemusic
sed -i 's/?????????????????????????????????/??????????????????/g' ./package/diy/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua


#???????????????
# sed -i 's/q reload/q restart/g' ./package/network/config/firewall/files/firewall.hotplug

#echo "????????????"
sed -i 's/option commit_interval.*/option commit_interval 1h/g' feeds/packages/net/nlbwmon/files/nlbwmon.config #???????????????????????????1h
# sed -i 's#option database_directory /var/lib/nlbwmon#option database_directory /etc/config/nlbwmon_data#g' feeds/packages/net/nlbwmon/files/nlbwmon.config #??????????????????????????????????????????

# echo '???????????? Irqbalance'
# sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

# Add minieap
rm -rf feeds/packages/net/minieap
svn co https://github.com/immortalwrt/packages/trunk/net/minieap packages/net/minieap feeds/packages/net/minieap

# Add mentohust & luci-app-mentohust
git clone --depth=1 https://github.com/BoringCat/luci-app-mentohust package/luci-app-mentohust
git clone --depth=1 https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk package/MentoHUST-OpenWrt-ipk

# ????????????
rm -rf ./feeds/luci/applications/luci-app-pushbot && \
git clone https://github.com/zzsj0928/luci-app-pushbot ./feeds/luci/applications/luci-app-pushbot
rm -rf ./feeds/luci/applications/luci-app-jd-dailybonus && \
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus ./feeds/luci/applications/luci-app-jd-dailybonus
rm -rf ./feeds/luci/applications/luci-app-serverchan && \
git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan ./feeds/luci/applications/luci-app-serverchan

git clone https://github.com/kiddin9/luci-app-dnsfilter package/luci-app-dnsfilter
# git clone https://github.com/tuanqing/install-program package/install-program

echo '??????aria2'
rm -rf feeds/luci/applications/luci-app-aria2 && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-aria2 feeds/luci/applications/luci-app-aria2
rm -rf feeds/packages/net/aria2 && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/aria2 feeds/packages/net/aria2

# rm -rf ./package/diy/adguardhome
rm -rf ./feeds/packages/net/adguardhome
# svn export https://github.com/openwrt/packages/trunk/net/adguardhome feeds/packages/net/adguardhome
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/adguardhome feeds/packages/net/adguardhome
# sed -i '/\t)/a\\t$(STAGING_DIR_HOST)/bin/upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/AdGuardHome' ./feeds/packages/net/adguardhome/Makefile
# sed -i '/init/d' feeds/packages/net/adguardhome/Makefile
# ln -sf ../../../feeds/packages/net/adguardhome ./package/feeds/packages/net/adguardhome
# cp -rf ./feeds/packages/net/adguardhome   ./package/diy/adguardhome

echo '
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_POLY1305_X86_64=y
' >> ./target/linux/x86/config-5.4

echo '
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_POLY1305_X86_64=y
' >> ./target/linux/x86/config-5.15

git clone https://github.com/yaof2/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
sed -i 's/???"), 1)/???"), 11)/g' ./package/luci-app-ikoolproxy/luasrc/controller/koolproxy.lua  #koolproxy

svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash ./package/diy/luci-app-openclash


# Fix libssh
# rm -rf feeds/packages/libs
# svn co https://github.com/openwrt/packages/trunk/libs/libssh feeds/packages/libs/
# Add apk (Apk Packages Manager)
# svn co https://github.com/openwrt/packages/trunk/utils/apk package/new/

# Add luci-udptools
# svn co https://github.com/zcy85611/Openwrt-Package/trunk/luci-udptools  package/new/
# svn co https://github.com/zcy85611/Openwrt-Package/trunk/udp2raw package/new/
# svn co https://github.com/zcy85611/Openwrt-Package/trunk/udpspeeder package/new/

# Add subconverter
# git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter  package/new/

# rm -rf ./feeds/packages/utils/runc/Makefile
# svn export https://github.com/openwrt/packages/trunk/utils/runc/Makefile ./feeds/packages/utils/runc/Makefile

# ChinaDNS
git clone -b luci --depth 1 https://github.com/pexcn/openwrt-chinadns-ng.git package/new/luci-app-chinadns-ng
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng package/new/chinadns-ng
# CPU ????????????
rm -rf  feeds/luci/applications/luci-app-cpufreq
svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq feeds/luci/applications/luci-app-cpufreq
ln -sf ../../../feeds/luci/applications/luci-app-cpufreq ./package/feeds/luci/luci-app-cpufreq
sed -i 's,1608,1800,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,2016,2208,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,1512,1608,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq

rm -rf ./packages/build/ddns-scripts_dnspod
# rm -rf ./package/lean/ddns-scripts_aliyun && svn co https://github.com/sirpdboy/build/trunk/ddns-scripts_aliyun package/lean/ddns-scripts_aliyun
sed -i '/boot()/,+2d' feeds/packages/net/ddns-scripts/files/etc/init.d/ddns
svn export https://github.com/linkease/istore-packages/trunk/ddns-scripts_dnspod package/lean/ddns-scripts_dnspod
svn export https://github.com/linkease/istore-packages/trunk/ddns-scripts_aliyun package/lean/ddns-scripts_aliyun


# Passwall
rm -rf ./feeds/packages/net/pdnsd-alt
rm -rf ./feeds/packages/net/shadowsocks-libev
rm -rf ./feeds/packages/net/xray-core
rm -rf ./feeds/packages/net/kcptun
rm -rf ./feeds/packages/net/brook
rm -rf ./feeds/packages/net/chinadns-ng
rm -rf ./feeds/packages/net/dns2socks
rm -rf ./feeds/packages/net/hysteria
rm -rf ./feeds/packages/net/ipt2socks
rm -rf ./feeds/packages/net/microsocks
rm -rf ./feeds/packages/net/naiveproxy
rm -rf ./feeds/packages/net/shadowsocks-rust
rm -rf ./feeds/packages/net/simple-obfs
rm -rf ./feeds/packages/net/ssocks
rm -rf ./feeds/packages/net/tcping
rm -rf ./feeds/packages/net/v2ray*
rm -rf ./feeds/packages/net/xray*
rm -rf ./feeds/packages/net/trojan*

#bypass
#rm -rf package/other/up/pass/luci-app-bypass
#git clone https://github.com/kiddin9/openwrt-bypass package/bypass
sed -i 's,default n,default y,g' package/other/up/pass/luci-app-bypass/Makefile
# sed -i 's,default n,default y,g' package/other/up/pass/luci-app-ssr-plus/Makefile

#  git clone https://github.com/loso3000/openwrt-passwall package/passwall
# svn co https://github.com/loso3000/openwrt-passwall/trunk/luci-app-passwall  package/passwall/luci-app-passwall

git clone https://github.com/xiaorouji/openwrt-passwall2 package/passwall2
# svn export https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall package/passwall/luci-app-passwall
svn export https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall package/passwall/luci-app-passwall
pushd package/passwall/luci-app-passwall
# sed -i 's,default n,default y,g' Makefile
popd 
# pushd package/pass/luci-app-ssr-plus
# sed -i 's,default n,default y,g' Makefile
# popd

svn export https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/new/tcping
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/new/trojan-go
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/new/brook
svn export https://github.com/QiuSimons/OpenWrt-Add/trunk/trojan-plus package/new/trojan-plus
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks package/new/ssocks
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/new/hysteria

echo ' ShadowsocksR Plus+'
# git clone https://github.com/fw876/helloworld package/ssr
# rm -rf  ./package/ssr/luci-app-ssr-plus
# ShadowsocksR Plus+ ??????
rm -rf ./feeds/packages/net/kcptun
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/new/tcping
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/new/trojan-go
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/new/brook
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks package/new/ssocks
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/microsocks package/new/microsocks
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/dns2socks package/new/dns2socks
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/ipt2socks package/new/ipt2socks
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/pdnsd-alt package/new/pdnsd
svn export https://github.com/QiuSimons/OpenWrt-Add/trunk/trojan-plus package/new/trojan-plus

# svn export https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-geodata package/lean/v2ray-geodata

svn export https://github.com/QiuSimons/openwrt-mos/trunk/v2ray-geodata package/new/v2ray-geodata

rm -rf ./feeds/packages/net/shadowsocks-libev
svn export https://github.com/coolsnowwolf/packages/trunk/net/shadowsocks-libev package/lean/shadowsocks-libev
svn export https://github.com/coolsnowwolf/packages/trunk/net/redsocks2 package/lean/redsocks2
svn export https://github.com/coolsnowwolf/lede/trunk/package/lean/srelay package/lean/srelay
svn export https://github.com/fw876/helloworld/trunk/trojan package/lean/trojan
svn export https://github.com/fw876/helloworld/trunk/tcping package/lean/tcping
svn export https://github.com/fw876/helloworld/trunk/dns2tcp package/lean/dns2tcp
svn export https://github.com/fw876/helloworld/trunk/shadowsocksr-libev package/lean/shadowsocksr-libev
svn export https://github.com/fw876/helloworld/trunk/simple-obfs package/lean/simple-obfs
svn export https://github.com/fw876/helloworld/trunk/naiveproxy package/lean/naiveproxy
svn export https://github.com/fw876/helloworld/trunk/lua-neturl package/lean/lua-neturl

rm -rf ./feeds/packages/net/v2ray-core
svn export https://github.com/fw876/helloworld/trunk/v2ray-core package/lean/v2ray-core
svn export https://github.com/fw876/helloworld/trunk/hysteria package/lean/hysteria
svn export https://github.com/fw876/helloworld/trunk/sagernet-core package/lean/sagernet-core
rm -rf ./feeds/packages/net/xray-core
svn export https://github.com/fw876/helloworld/trunk/xray-core package/lean/xray-core
svn export https://github.com/fw876/helloworld/trunk/v2ray-plugin package/lean/v2ray-plugin
svn export https://github.com/fw876/helloworld/trunk/xray-plugin package/lean/xray-plugin
svn export https://github.com/fw876/helloworld/trunk/shadowsocks-rust package/lean/shadowsocks-rust
rm -rf ./feeds/packages/net/kcptun
svn export https://github.com/immortalwrt/packages/trunk/net/kcptun feeds/packages/net/kcptun
ln -sf ../../../feeds/packages/net/kcptun ./package/feeds/packages/kcptun

# VSSR
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  ./package/vssr/luci-app-vssr
# git clone -b master --depth 1 https://github.com/jerrykuku/luci-app-vssr.git package/lean/luci-app-vssr
# git clone -b master --depth 1 https://github.com/jerrykuku/lua-maxminddb.git package/lean/lua-maxminddb
# sed -i 's,default n,default y,g' ./package/lean/luci-app-vssr/Makefile
#sed -i '/result.encrypt_method/a\result.fast_open = "1"' package/lean/luci-app-vssr/root/usr/share/vssr/subscribe.lua
#sed -i 's,ispip.clang.cn/all_cn.txt,raw.sevencdn.com/QiuSimons/Chnroute/master/dist/chnroute/chnroute.txt,g' package/lean/luci-app-vssr/luasrc/controller/vssr.lua
#sed -i 's,ispip.clang.cn/all_cn.txt,raw.sevencdn.com/QiuSimons/Chnroute/master/dist/chnroute/chnroute.txt,g' package/lean/luci-app-vssr/root/usr/share/vssr/update.lua
pushd /package/vssr/luci-app-vssr
 # sed -i 's,default n,default y,g' Makefile
 # sed -i 's,+shadowsocks-libev-ss-local ,,g' Makefile
popd

# ??? X86 ??????????????? Shadowsocks-rust
sed -i '/Rust:/d' package/lean/luci-app-ssr-plus/Makefile
sed -i '/Rust:/d' package/ssr/luci-app-ssr-plus/Makefile
sed -i '/Rust:/d' package/passwall/luci-app-passwall/Makefile
sed -i '/Rust:/d' package/vssr/luci-app-vssr/Makefile
sed -i '/Rust:/d' package/other/up/pass/luci-app-bypass/Makefile
sed -i '/Rust:/d' package/other/up/pass/luci-ssr-plus/Makefile


# ????????????????????????
# sed -i "s/bootstrap/chuqitopd/g" feeds/luci/modules/luci-base/root/etc/config/luci
# sed -i 's/bootstrap/chuqitopd/g' feeds/luci/collections/luci/Makefile
echo "??????????????????"
# sed -i 's/+luci-theme-bootstrap/+luci-theme-opentopd/g' feeds/luci/collections/luci/Makefile
# sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

rm -rf ./package/diy/luci-theme-edge
rm -rf ./package/build/luci-theme-darkmatter
# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new package/lean/luci-theme-atmaterial_new
# git clone https://github.com/john-shine/luci-theme-darkmatter.git package/diy/darkmatter
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/diy/luci-theme-argon
git clone -b 18.06  https://github.com/kiddin9/luci-theme-edge.git package/new/luci-theme-edge
git clone https://github.com/thinktip/luci-theme-neobird.git   package/new/luci-theme-neobird


# Remove some default packages
# sed -i 's/luci-app-ddns//g;s/luci-app-upnp//g;s/luci-app-adbyby-plus//g;s/luci-app-vsftpd//g;s/luci-app-ssr-plus//g;s/luci-app-unblockmusic//g;s/luci-app-vlmcsd//g;s/luci-app-wol//g;s/luci-app-nlbwmon//g;s/luci-app-accesscontrol//g' include/target.mk
# sed -i 's/luci-app-adbyby-plus//g;s/luci-app-vsftpd//g;s/luci-app-ssr-plus//g;s/luci-app-unblockmusic//g;s/luci-app-vlmcsd//g;s/luci-app-wol//g;s/luci-app-nlbwmon//g;s/luci-app-accesscontrol//g' include/target.mk

# git clone https://github.com/openwrt-dev/po2lmo.git
# cd po2lmo
# make && sudo make install

# Fix SDK
# sed -i '/$(SDK_BUILD_DIR)\/$(STAGING_SUBDIR_HOST)\/usr\/bin/d;/LICENSE/d' ./target/sdk/Makefile
 

cp -f ./package/build/banner ./package/base-files/files/etc/banner
cat ./package/build/profile > package/base-files/files/etc/profile
# cp -rf ./package/build/ramips/*  target/linux/ramips/*

cp -rf ./package/other/luci/*  ./feeds/luci/*

#??????nat?????? 
cat ./package/build/set/sysctl.conf >  package/base-files/files/etc/sysctl.conf
# version=$(grep "DISTRIB_REVISION=" package/lean/default-settings/files/zzz-default-settings  | awk -F "'" '{print $2}')
# sed -i '/root:/d' ./package/base-files/files/etc/shadow
# sed -i 's/root::0:0:99999:7:::/root:$1$tzMxByg.$e0847wDvo3JGW4C3Qqbgb.:19052:0:99999:7:::/g' ./package/base-files/files/etc/shadow   #tiktok
# sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' ./package/base-files/files/etc/shadow    #password

#sed -i 's/US/CN/g ; s/OpenWrt/iNet/g ; s/none/psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# sed -i "s/hostname='OpenWrt'/hostname='EzOpWrt'/g" package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

# curl -fsSL  https://raw.githubusercontent.com/loso3000/other/master/patch/default-settings/zzz-default-settings1 > ./package/lean/default-settings/files/zzz-default-settings

# sed -i 's/KERNEL_PATCHVER:=5.18/KERNEL_PATCHVER:=5.4/g' ./target/linux/*/Makefile
# sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=5.4/g' ./target/linux/*/Makefile

# echo '???????????? Irqbalance'
ver1=`grep "KERNEL_PATCHVER:="  target/linux/x86/Makefile | cut -d = -f 2` #????????????????????????????????????5.10
export VER2="$(grep "KERNEL_PATCHVER:="  ./target/linux/x86/Makefile | cut -d = -f 2)"

date1='Ipv6-Plus-R'`TZ=UTC-8 date +%Y.%m.%d -d +"12"hour`
date1='Ipv6-Plus-R2022.11.01'
sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/20221101-Ipv6-Plus-5.15-/g' include/image.mk
if [ "$VER2" = "5.4" ]; then
#sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/20220415-Ipv6-Plus-5.4-/g' include/image.mk
    sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/$(shell TZ=UTC-8 date +%Y%m%d -d +12hour)-Ipv6-Plus-5.4-/g' include/image.mk
elif [ "$VER2" = "5.10" ]; then
#sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/20220401-Ipv6-Plus-5.10-/g' include/image.mk
    sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/$(shell TZ=UTC-8 date +%Y%m%d -d +12hour)-Ipv6-Plus-5.10-/g' include/image.mk
elif [ "$VER2" = "5.15" ]; then
#sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/20220415-Ipv6-Plus-5.15-/g' include/image.mk
    sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/$(shell TZ=UTC-8 date +%Y%m%d -d +12hour)-Ipv6-Plus-5.15-/g' include/image.mk
elif [ "$VER2" = "5.19" ]; then
#sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/20220415-Ipv6-Plus-5.15-/g' include/image.mk
    sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/$(shell TZ=UTC-8 date +%Y%m%d -d +12hour)-Ipv6-Plus-5.19-/g' include/image.mk
fi

echo "DISTRIB_REVISION='${date1} by Sirpdboy'" > ./package/base-files/files/etc/openwrt_release1
echo ${date1}' by Sirpdboy ' >> ./package/base-files/files/etc/banner
# echo "DISTRIB_REVISION='${date1} '" > ./package/base-files/files/etc/openwrt_release1
# echo ${date1}'  ' >> ./package/base-files/files/etc/banner
echo '---------------------------------' >> ./package/base-files/files/etc/banner

sed -i 's/+"), 10)/+"), 0)/g' ./package/ssr/luci-app-ssr-plus//luasrc/controller/shadowsocksr.lua  #shadowsocksr
sed -i 's/+"), 10)/+"), 0)/g' ./package/lean/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua  #shadowsocksr
# sed -i 's/h"), 50)/h"), 8)/g' ./package/diy/luci-app-openclash/luasrc/controller/openclash.lua   #openclash
sed -i 's/+"),1)/+"),11)/g' ./package/diy/luci-app-adblock-plus/luasrc/controller/adblock.lua   #adblock
sed -i 's/),9)/),12)/g' ./package/luci-app-dnsfilter/luasrc/controller/dnsfilter.lua   #dnsfilter
./scripts/feeds update -i
