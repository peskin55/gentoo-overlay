# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 gnome2-utils meson multilib readme.gentoo-r1 xdg-utils

DESCRIPTION="KDE Connect implementation for Gnome Shell"
HOMEPAGE="https://github.com/andyholmes/gnome-shell-extension-gsconnect"
EGIT_REPO_URI="https://github.com/andyholmes/${PN}.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="firewalld +nemo +nautilus webext"

COMMON_DEPEND="dev-libs/glib:2"
RDEPEND="${COMMON_DEPEND}
	app-eselect/eselect-gnome-shell-extensions
	>=dev-libs/gjs-1.48
	=gnome-base/gnome-shell-3.36*
	gnome-base/gvfs
	gnome-extra/evolution-data-server
	|| ( media-libs/libcanberra media-libs/gsound )
	nautilus? (
		dev-python/nautilus-python
		gnome-base/nautilus[introspection] )
"
DEPEND="${COMMON_DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

DISABLE_AUTOFORMATTING="yes"
DOC_CONTENTS="For knowing more about how to do the setup, please visit:
https://github.com/andyholmes/gnome-shell-extension-gsconnect/wiki/Installation"

src_configure() {
	emesonargs=(
				-Dpost_install=false
				-Dgnome_shell_libdir=/usr/$(get_libdir)/gnome-shell
				-Dgsettings_schemadir=/usr/share/glib-2.0/schemas
				-Dsession_bus_services_dir=/usr/share/dbus-1/services
				$(meson_use firewalld)
				$(meson_use nemo)
				$(meson_use nautilus)
				$(meson_use webext webextension)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	readme.gentoo_create_doc
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	ebegin "Updating list of installed extensions"
	eselect gnome-shell-extensions update
	eend $?
	readme.gentoo_print_elog
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
