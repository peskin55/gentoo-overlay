# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop gnome2-utils readme.gentoo-r1 xdg

DESCRIPTION="Intelligent Python IDE with unique code assistance and analysis"
HOMEPAGE="http://www.jetbrains.com/pycharm/"
SRC_URI="http://download.jetbrains.com/python/${P}.tar.gz"

LICENSE="PyCharm_Academic PyCharm_Classroom PyCharm PyCharm_OpenSource PyCharm_Preview"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+bundled-jdk"

RDEPEND="!bundled-jdk? ( >=virtual/jre-1.8 )
	dev-libs/libdbusmenu
	dev-python/pip"

RESTRICT="mirror strip"

QA_PREBUILT="*"

MY_PN=${PN/-professional/}
S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	dodir "/opt"
	cp -R -p "${S}" "${ED}/opt/${PN}"

	if ! use bundled-jdk; then
		rm -rf "${D}/opt/pycharm-professional/jbr" || die
	fi

	dosym ../../"opt/${PN}/bin/pycharm.sh" "/usr/bin/${PN}"
	rm -f "${D}/opt/pycharm-professional/jbr/lib/jcef_helper"
	rm -f "${D}/opt/pycharm-professional/jbr/lib/libjcef.so"
	domenu "${FILESDIR}/${PN}.desktop"
	domenu "${FILESDIR}/charm.desktop" 
	dobin "${FILESDIR}/charm"
	for PNG in 16 22 24 32 36 48 64 72 96 128 192 256 512
	do
		newicon --size "${PNG}" "${FILESDIR}/${PN%-*}.${PNG}.png" "${PN}.png"
	done
	newicon -s scalable "${FILESDIR}/${PN%-*}.svg" "${PN}.svg"

	local rub

	for rub in aarch64 mips64el ppc64le; do
		rm -rf "${D}/opt/pycharm-professional/lib/pty4j-native/linux/${rub}" || die
	done
}
