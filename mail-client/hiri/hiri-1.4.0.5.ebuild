# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="Exchange-ready email client aiming to replace Outlook"
HOMEPAGE="https://hiri.com"
SRC_URI="https://feedback.${PN}.com/dist/downloads/${PN^}-x86_64-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

RESTRICT="mirror strip"

S="${WORKDIR}"

src_install() {
	dodir "/opt"
	cp -a "${S}/${P/-/_}" "${D}/opt/${PN}"
	domenu "${FILESDIR}/${PN}.desktop"
	doicon "${S}/${P/-/_}/${PN}.png"
	dosym ../../"opt/${PN}/${PN}.sh" "/usr/bin/${PN}"
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postinst
}
