# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson xdg-utils gnome2-utils

DESCRIPTION="Xreader is a document viewer capable of displaying multiple and single page
document formats like PDF and Postscript"
HOMEPAGE="https://github.com/linuxmint/xreader"
EGIT_REPO_URI="https://github.com/linuxmint/xreader.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="comic +djvu +dvi +t1lib +epub +pdf +postscript +pixbuff +tiff +xps +print +keyring +previewer +thumbnailer docs +introspection +dbus debug"

DEPEND="app-text/libgxps"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=( "${FILESDIR}/${P}-patch.patch" )

src_configure() {
	local emesonargs=( -Dmathjax-directory=/usr/share/mathjax
					$(meson_use postscript ps)
					$(meson_use print gtk_unix_print)
					$(meson_use comic)
					$(meson_use djvu)
					$(meson_use dvi)
					$(meson_use t1lib)
					$(meson_use epub)
					$(meson_use pdf)
					$(meson_use pixbuff)
					$(meson_use tiff)
					$(meson_use xps)
					$(meson_use keyring)
					$(meson_use previewer)
					$(meson_use thumbnailer)
					$(meson_use docs)
					$(meson_use introspection)
					$(meson_use dbus)
					$(meson_use debug)
		)
		meson_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
	gnome2_schemas_update
}
