# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit desktop meson gnome2-utils python-single-r1 xdg-utils udev

MY_PN="${PN^}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="2FA code generator for GNOME"
HOMEPAGE="https://gitlab.gnome.org/World/Authenticator"
SRC_URI="https://gitlab.gnome.org/World/${MY_PN}/-/archive/${PV}/${MY_P}.tar.bz2 -> ${P}.tar.bz2"

LICENSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/appstream-glib
	gui-libs/libhandy
	media-gfx/gnome-screenshot
	$(python_gen_cond_dep '
		dev-python/pyzbar[${PYTHON_USEDEP}]
		dev-python/tabulate[${PYTHON_USEDEP}]
		dev-python/pyotp[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/beautifulsoup[${PYTHON_USEDEP}]
		dev-python/yoyo-migrations[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/sqlparse[${PYTHON_USEDEP}]
		dev-python/pyfavicon[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/meson
		dev-libs/gobject-introspection
"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${P}-references.patch" )

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	meson_src_configure
}

src_install () {
	meson_src_install
	for PNG in 16 22 24 32 36 48 64 72 96 128 192 256 512
	do
		newicon --size "${PNG}" "${FILESDIR}/com.github.bilelmoussaoui.Authenticator.${PNG}.png" "com.github.bilelmoussaoui.Authenticator.png"
	done
	python_optimize
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
