# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.22

inherit git-r3 meson vala

DESCRIPTION="Session indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-session"
EGIT_REPO_URI="https://github.com/elementary/wingpanel-indicator-session.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-5.2.0
	pantheon-base/wingpanel
	sys-apps/accountsservice:=
	x11-libs/gtk+:3
"

DEPEND="${RDEPEND}
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_src_prepare
}
