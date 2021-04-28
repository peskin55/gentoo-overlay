# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
inherit desktop python-any-r1 xdg-utils

DESCRIPTION="A hackable text editor for the 21st Century"
HOMEPAGE="https://atom.io/"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${PN}-amd64.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="!app-editors/atom
	${PYTHON_DEPS}
	dev-vcs/git
	x11-libs/gtk+:3
	virtual/libudev
	dev-libs/libgcrypt
	x11-libs/libnotify
	x11-libs/libXtst
	dev-libs/nss
	gnome-base/gvfs
	x11-misc/xdg-utils
	sys-libs/libcap
	x11-libs/libX11
	x11-libs/libXScrnSaver
	media-libs/alsa-lib
	x11-libs/libxkbfile
	net-misc/curl"

S="${WORKDIR}/${P}-amd64"

src_install() {
	newmenu "${FILESDIR}/${PN}-1.55.0-menu" "${PN}.desktop"
	doicon "${S}/${PN}.png"
	cp -a "${S}" "${D}/usr/share/atom"
	newbin "${FILESDIR}/${PN}-1.55.0-nohup-bin-file" "${PN}"
	dosym ../"share/${PN}/resources/app/apm/node_modules/.bin/apm" "/usr/bin/apm"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
