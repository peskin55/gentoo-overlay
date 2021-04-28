# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg

VALA_MAX_API_VERSION="0.48"

DESCRIPTION="Code editor designed for elementary OS"
HOMEPAGE="https://github.com/elementary/code"
SRC_URI="https://github.com/elementary/code/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="+plugins +webkit +vala"

DEPEND="
	>=dev-lang/vala-0.40
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	app-text/editorconfig-core-c
	app-text/gtkspell:3
	>=dev-libs/glib-2.30:2
	>=dev-libs/granite-5.2.0
	>=dev-libs/libgee-0.8.5:0.8
	dev-libs/libgit2-glib
	dev-libs/libpeas[gtk]
	gnome-extra/zeitgeist
	media-libs/fontconfig
	net-libs/libsoup:2.4
	webkit? ( net-libs/webkit-gtk:4 )
	>=x11-libs/gtk+-3.6:3
	>=x11-libs/gtksourceview-3.24:3.0
	x11-libs/vte:2.91
"

PATCHES="${FILESDIR}/${PN}-3.4.1-webkit_option.patch"


S="${WORKDIR}/code-${PV}"

src_prepare() {
	default
	usex vala && vala_src_prepare
}

src_configure() {
	local emesonargs=(
		$(meson_use plugins)
		$(meson_use webkit)
	)
	meson_src_configure
}


pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
