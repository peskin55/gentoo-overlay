# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="ffb6b435c7da83c210a8f8a53af5082f6ed3816b"

inherit gnome2 meson vala

DESCRIPTION="Library full of GTK+ widgets"
HOMEPAGE="https://gitlab.gnome.org/exalm/libadwaita"
SRC_URI="https://gitlab.gnome.org/exalm/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.bz2 -> ${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="vala"
DEPEND="x11-libs/gtk+"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${COMMIT}"

src_prepare() {
	default
	usex vala && vala_src_prepare --api-version 0.50
}

src_configure() {
	local emesonargs=(
		$(meson_use vala vapi)
		-Dtests=false
		-Dgtk_doc=true
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_pkg_preinst
}

pkg_postinst() {
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}

