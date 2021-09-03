# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools gnome2-utils xdg

DESCRIPTION="CPU Monitor and Power Manager"
HOMEPAGE="Power Manager"
SRC_URI="https://github.com/konkor/${PN##*-}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${P/gnome-shell-extension-/}"

src_prepare() {
	default
	eautoreconf
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
