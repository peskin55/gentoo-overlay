# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

inherit meson gnome2-utils git-r3 python-single-r1

DESCRIPTION="Screensaver for Cinnamon"
HOMEPAGE="https://projects.linuxmint.com/cinnamon/"
EGIT_REPO_URI="https://github.com/linuxmint/cinnamon-screensaver.git"

LICENSE="GPL-2+"
SLOT="0"
IUSE="setres locking"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="
	>=dev-libs/glib-2.37.3:2[dbus]
	>=x11-libs/gtk+-3.1.4:3[introspection]
	>=gnome-extra/cinnamon-desktop-4.4:0=
	>=gnome-base/gsettings-desktop-schemas-0.1.7
	>=dev-libs/dbus-glib-0.78

	sys-apps/dbus
	sys-libs/pam
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	x11-themes/adwaita-icon-theme

	${PYTHON_DEPS}

"

RDEPEND="${COMMON_DEPEND}
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		dev-python/setproctitle[${PYTHON_USEDEP}]
		dev-python/xapp[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
	')
"
DEPEND="${COMMON_DEPEND}
	dev-util/gdbus-codegen
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
	x11-base/xorg-proto
"

src_prepare() {
	python_fix_shebang src
	default
}

src_configure() {
	emesonargs=( -Dpam-prefix=/etc/pam.d
		$(meson_use setres)
		$(meson_use locking)
	)
	meson_src_configure
}
