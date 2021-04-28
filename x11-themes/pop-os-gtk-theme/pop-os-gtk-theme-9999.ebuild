# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 gnome2-utils meson xdg-utils

DESCRIPTION="System76 Pop GTK+ Theme"
HOMEPAGE="https://github.com/pop-os/gtk-theme"
EGIT_REPO_URI="https://github.com/pop-os/gtk-theme.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+icons +gnome +gsr +gtk +sound +session compact +default +dark +light"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""


src_configure() {
	local emesonargs=(
				$(meson_use icons)
				$(meson_use gnome gnome-shell)
				$(meson_use gsr gnome-shell-gresource)
				$(meson_use gtk)
				$(meson_use sound sounds)
				$(meson_use session sessions)
				$(meson_use compact communitheme_compat)
				$(meson_use default)
				$(meson_use dark)
				$(meson_use light)
		)
	meson_src_configure
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

