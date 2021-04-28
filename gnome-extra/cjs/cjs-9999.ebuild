# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools gnome2-utils meson git-r3 pax-utils virtualx

DESCRIPTION="Linux Mint's fork of gjs for Cinnamon"
HOMEPAGE="https://projects.linuxmint.com/cinnamon/"
EGIT_REPO_URI="https://github.com/linuxmint/cjs.git"

LICENSE="MIT || ( MPL-1.1 LGPL-2+ GPL-2+ )"
SLOT="0"
IUSE="+cairo examples test"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-lang/spidermonkey:52
	>=dev-libs/glib-2.42:2
	>=dev-libs/gobject-introspection-1.41.4:=
	sys-libs/readline:0=
	dev-libs/libffi:0=
	cairo? ( x11-libs/cairo[X,glib] )
	x11-libs/gtk+:3 "

DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	test? ( sys-apps/dbus )
	sys-devel/autoconf-archive
"
# Cinnamon 2.2 does not work with this release.
RDEPEND="${RDEPEND}
	!<gnome-extra/cinnamon-2.4
"

RESTRICT="test"
src_configure() {
	# FIXME: --enable-systemtap installs files in ${D}/${D} for some reason
	local mymesonargs=(
			-Dsystemtap="false"
			-Ddtrace="true"
			$(meson_feature cairo)
		)
		meson_src_configure
}
