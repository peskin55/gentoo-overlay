# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop multilib xdg

DESCRIPTION="Firefox-based privacy aware web browser"
HOMEPAGE="https://basilisk-browser.org"
SRC_URI="https://cdn.${PN}.net/releases/linux64/installer/${PN}-G${PV}.en-US.linux-x86_64.tar.bz2 -> ${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="strip mirror"


DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}"

src_install() {
	dodir "/usr/$(get_libdir)"
	cp -a "${S}" "${D}"/usr/$(get_libdir)
	dosym ../$(get_libdir)/"${PN}/${PN}" "/usr/bin/${PN}"
	domenu "${FILESDIR}/${PN}.desktop"
	for SIZE in 16 32 48 64 128
	do
		newicon --size "${SIZE}" "${S}/browser/chrome/icons/default/default${SIZE}.png" "${PN}.png"
	done
}
