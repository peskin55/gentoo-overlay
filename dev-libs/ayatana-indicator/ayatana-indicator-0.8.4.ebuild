# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Indicator Service"
HOMEPAGE="https://ayatanaindicators.github.io/code/"
SRC_URI="https://github.com/AyatanaIndicators/lib${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk3"

DEPEND="dev-libs/ayatana-ido"
RDEPEND="${DEPEND}
		gtk3? ( x11-libs/gtk+:3 ) !gtk3? ( x11-libs/gtk+:2 )
"
BDEPEND=""

S="${WORKDIR}/lib${P}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_with gtk3 gtk 3) \
		--enable-ido \
		--enable-shared \
		--disable-static
}

src_install() {
	emake DESTDIR="${D}" install
	dosym "${PN}3-0.4.pc" "/usr/lib64/pkgconfig/indicator3-0.1.pc"
	dosym "lib${PN}" "/usr/include/lib${PN}3-0.4/libindicator"
}
