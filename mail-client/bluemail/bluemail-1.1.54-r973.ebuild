# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="BlueMail"

inherit desktop unpacker xdg

DESCRIPTION="BlueMail email Client"
HOMEPAGE="https://bluemail.me"
SRC_URI="https://download.${PN}.me/${MY_PN}/deb/${MY_PN}.deb -> ${PF}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_prepare() {
	gunzip "${S}/usr/share/doc/bluemail/changelog.gz"
	default
}

src_install() {
	dodir "/opt"
	cp -R -p "${S}/opt/${MY_PN}" "${D}/opt"
	domenu "${S}/usr/share/applications/${PN}.desktop"
	insinto "/usr/share"
	doins -r "${S}/usr/share/icons"
	dodoc "${S}/usr/share/doc/bluemail/changelog"
}
