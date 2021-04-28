# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop unpacker xdg

DESCRIPTION="A terminal for the modern age"
HOMEPAGE="https://github.com/Eugeny/terminus"
SRC_URI="https://github.com/Eugeny/${PN}/releases/download/v${PV}/${P}-linux.deb -> ${P}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_prepare() {
	sed -i -e "s:Exec=/opt/Terminus/terminus:Exec=/usr/share/terminus/terminus:g" -e "s:Categories=Utility;:Categories=GTK;Utility;TerminalEmulator;System;:g" "${S}/usr/share/applications/${PN}.desktop"
	default
}

src_install() {
	domenu "${S}/usr/share/applications/${PN}.desktop"
	cp -a "${S}/opt/${PN//t/T}" "${D}/usr/share/${PN}"
	for SIZE in 16 32 64 128 256 512
	do
		doicon --size "${SIZE}" "${S}/usr/share/icons/hicolor/${SIZE}x${SIZE}/apps/${PN}.png"
	done
	dosym ../"share/${PN}/${PN}" "/usr/bin/${PN}"
}
