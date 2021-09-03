# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3 gnome2-utils

DESCRIPTION="Open terminal within Nautilus"
HOMEPAGE="https://github.com/flozz/nautilus-terminal"
EGIT_REPO_URI="https://github.com/flozz/${PN}.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="gnome-base/nautilus
		dev-python/nautilus-python
		dev-python/setuptools
		dev-python/psutil
		x11-libs/vte
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	distutils-r1_src_install
	rm -f "${ED}/usr/share/glib-2.0/schemas/gschemas.compiled"

}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
