# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3 gnome2-utils

DESCRIPTION="libnemo-extension Python bindings"
HOMEPAGE="https://github.com/linuxmint"
EGIT_REPO_URI="https://github.com/linuxmint/nemo-extensions.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="gnome-extra/xreader
	x11-libs/gtksourceview:3.0
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${P}/${PN}"


pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
