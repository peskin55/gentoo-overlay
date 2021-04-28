# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop unpacker xdg

MY_PN="Bitwarden"
DESCRIPTION="Bitwarden password manager desktop client"
HOMEPAGE="https://bitwarden.com/"
SRC_URI="https://github.com/${PN%%-*}/desktop/releases/download/v${PV}/${MY_PN}-${PV}-amd64.deb -> ${PF}.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	app-accessibility/at-spi2-atk:2
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
"

S="${WORKDIR}"

QA_PREBUILT="
	opt/${MY_PN}/*.so
	opt/${MY_PN}/${PN%%-*}
	opt/${MY_PN}/chrome-sandbox
"

src_install() {
	dodir "/opt"
	cp -R -p "${S}/opt/${MY_PN}" "${ED}/opt"
	fperms 755 "/opt/${MY_PN}/${PN%%-*}"
	fperms 4755 "/opt/${MY_PN}/chrome-sandbox"

	domenu "${S}/usr/share/applications/${PN%%-*}.desktop"

	insinto "/usr/share"
	doins -r "${S}/usr/share/icons"
	dosym ../../"opt/${MY_PN}/${PN%%-*}" "/usr/bin/${PN%%-*}"
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
