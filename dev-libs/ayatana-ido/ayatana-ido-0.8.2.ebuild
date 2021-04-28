# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools vala

DESCRIPTION="A library and indicator to take menus from applications and place them in the panel."
HOMEPAGE="https://ayatanaindicators.github.io/"
SRC_URI="https://github.com/AyatanaIndicators/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(vala_depend)"
RDEPEND="${DEPEND}
		dev-libs/gobject-introspection
"
BDEPEND=""


src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--enable-introspection \
		--disable-static \
		--enable-shared
}

src_compile() {
	emake VALA_API_GEN="vapigen-0.50"
}
