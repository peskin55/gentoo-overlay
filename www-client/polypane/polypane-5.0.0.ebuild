# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop unpacker xdg

DESCRIPTION="Browser for building responsive websites and apps."
HOMEPAGE="https://polypane.app"
SRC_URI="https://github.com/firstversionist/${PN}/releases/download/v${PV}/${P/-/_}_amd64.deb -> ${P}.deb"

LICENSE=""
SLOT="0"
RESTRICT="mirror strip"
KEYWORDS="~amd64 ~x86"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"


src_prepare() {
	sed "s|text/html;text/html|text/html|g" -i "${S}/usr/share/applications/${PN}.desktop"
	default
	gunzip "${S}/usr/share/doc/${PN}/changelog.gz"
}

src_install() {
	cp -R -p "${S}/opt" "${ED}"
	domenu "${S}/usr/share/applications/${PN}.desktop"
	insinto "/usr/share"
	doins -r "${S}/usr/share/icons" "${S}/usr/share/mime"
	dodoc "${S}/usr/share/doc/${PN}/changelog"
	dosym ../../"opt/${PN^}/${PN}" "/usr/bin/${PN}"
	fperms 4755 "/opt/${PN^}/chrome-sandbox"
}

