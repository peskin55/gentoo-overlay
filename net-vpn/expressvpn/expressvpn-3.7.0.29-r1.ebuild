# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 desktop systemd unpacker xdg

DESCRIPTION="Propietary VPN client for Linux"
HOMEPAGE="https://expressvpn.com"
SRC_URI="https://download.${PN}.xyz/clients/linux/${P/-/_}-beta_amd64.deb -> ${PF}.deb"

LICENSE="ExpressVPN"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
RESTRICT="mirror strip"
IUSE="systemd"

DEPEND="sys-apps/net-tools
	systemd? ( sys-apps/systemd )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

PATCHES=(
	"${FILESDIR}/${PN}-agent-desktop-file.patch"
	)

src_unpack() {
	unpack_deb "${A}"
##	bsdtar -xf "${DISTDIR}/${P}.deb"
##	tar xf data*tar* -C "${WORKDIR}"
##	tar xf control*tar* -C "${WORKDIR}"
}

src_prepare() {
	gunzip "${S}/usr/share/doc/expressvpn/changelog.gz"
	default
}

src_install() {
	dodir /usr/lib{,64}
	for BIN in expressvpn{,-browser-helper}
	do
		dobin "${S}/usr/bin/${BIN}"
	done
	dosbin "${S}/usr/sbin/${PN}d"
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	dodoc "${S}/usr/share/doc/expressvpn/changelog"
	doman "${S}/usr/share/man/man1/${PN}.1"
	newbashcomp "${S}/usr/lib/${PN}/bash-completion" ${PN}
	use systemd && "${S}/systemd_dounit usr/lib/${PN}/${PN}.service"
	domenu "${S}/usr/lib/${PN}/${PN}-agent.desktop"
	newicon "${S}/usr/lib/${PN}/icon.png" "${PN}-agent.png"
	cp -rp "${S}/usr/lib/${PN}" "${D}/usr/lib/${PN}"
	dosym "${PN}-browser-helper" "/usr/bin/${PN}-agent"
	dosym ../"lib/${PN}" "/usr/lib64/${PN}"
	insopts -m 0644
	insinto "/var/lib/${PN}"
	newins "${FILESDIR}/${PN}-resolvconf-var-lib" "resolv.conf"
	dosym ../"bin/ip" "/sbin/ip"
}

pkg_preinst() {
	/usr/bin/chattr -i /etc/resolv.conf
	local bakfile=/var/lib/expressvpn/resolv.conf.orig
	if [ -L "${bakfile}" ]
	then
		mv -f "${bakfile}" /etc/resolv.conf
	elif [ -f "${bakfile}" ]
	then
		cat "${bakfile}" > /etc/resolv.conf
		rm -f /var/lib/expressvpn/resolv.conf.orig
	fi
}

pkg_postinst() {
	mkdir -p "/var/lib/expressvpn/certs"
	chown root "/var/lib/expressvpn/certs"
	chmod 755 "/var/lib/expressvpn/certs"
	/usr/sbin/expressvpnd --workdir "/var/lib/expressvpn" generate-client-ca
	/usr/sbin/expressvpnd --workdir "/var/lib/expressvpn" generate-client-certs
	rm -f "/var/lib/expressvpn/certs/client.req"
	rm -f "/var/lib/expressvpn/certs/clientca.srl"
	chmod 644 "/var/lib/expressvpn/certs/client.key"
	if [ -e "/var/lib/expressvpn/userdata.dat" ] && [ ! -e "/var/lib/expressvpn/userdata2.dat" ]; then
			mv "/var/lib/expressvpn/userdata.dat" "/var/lib/expressvpn/userdata2.dat"
	fi
	if [ -e "/var/lib/expressvpn/userdata2.dat" ] && [ ! -e "/var/lib/expressvpn/data/e21fb121.bin" ]; then
			echo "Upgrade in progress..."
			mkdir -p "/var/lib/expressvpn/data"
			chmod 700 "/var/lib/expressvpn/data"
			/usr/sbin/expressvpnd \
					--workdir "/var/lib/expressvpn" \
					--client-version "3.4.1beta" \
					--client-build "4" \
					migrate >/dev/null 2>&1
	fi
	xdg_pkg_postinst
}

pkg_postrm() {
	rm -rf /var/lib/expressvpn || true
	rm -rf /var/log/expressvpn || true
	rm -rf /var/run/expressvpn || true
	xdg_pkg_postrm
}
