# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="${PV:0:1}"
MY_PN="${PN/-/_}"
MY_P="${MY_PN}_${MY_PV}"

inherit desktop gnome2-utils xdg-utils

DESCRIPTION="Sophisticated text editor for code, markup and prose"
HOMEPAGE="http://www.sublimetext.com"
SRC_URI="https://download.${PN/-/}.com/${MY_P}_build_${PV}_x64.tar.bz2 -> ${P}.tar.bz2"

LICENSE="Sublime"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="bindist mirror strip"

DEPEND=">=media-libs/libpng-1.2.46:*
	x11-libs/gtk+:3
"
RDEPEND="${DEPEND}"

QA_PREBUILT="*"

S="${WORKDIR}/${MY_P}"

src_install() {
	for SIZE in 16 32 48 128 256
	do
		doicon --size "${SIZE}" "${S}/Icon/${SIZE}x${SIZE}/${PN}.png"
	done
	domenu "${S}/${MY_PN}.desktop"
	dodir "/opt"
	dobin "${FILESDIR}/subl"
	cp -a "${S}" "${D}/opt/${MY_PN}"
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
