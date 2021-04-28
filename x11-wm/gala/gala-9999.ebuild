# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.28

inherit git-r3 gnome2-utils meson vala xdg-utils

DESCRIPTION="Pantheon's Window Manager"
HOMEPAGE="https://github.com/elementary/gala"
EGIT_REPO_URI="https://github.com/elementary/gala.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

RDEPEND="
	>=dev-libs/glib-2.44:2
	dev-libs/granite
	dev-libs/libgee:0.8
	gnome-base/gnome-desktop:3
	gnome-base/gnome-settings-daemon
	>=media-libs/clutter-1.12
	media-libs/clutter-gtk
	x11-libs/bamf
	>=x11-libs/gtk+-3.10.0:3
	>=x11-misc/plank-0.11.0
	>=x11-wm/mutter-3.34.0:=
"
DEPEND="${RDEPEND}
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/${P}-vala-0.46.patch" )

src_prepare() {
	default
	vala_src_prepare
	sed "s/find_program('vapigen'/find_program('${VAPIGEN}'/g" -i "${S}/meson.build"
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
