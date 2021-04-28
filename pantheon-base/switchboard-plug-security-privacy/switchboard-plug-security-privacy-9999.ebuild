# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.22

inherit gnome2-utils meson vala git-r3

DESCRIPTION="Configure various aspects of the security of the system."
HOMEPAGE="https://github.com/elementary/switchboard-plug-security-privacy"
EGIT_REPO_URI="https://github.com/elementary/switchboard-plug-security-privacy.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite
	pantheon-base/switchboard
	>=sys-auth/polkit-0.115
	x11-libs/gtk+:3
	x11-misc/light-locker
"
DEPEND="${RDEPEND}
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

src_prepare() {
	default
	vala_src_prepare
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
