# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit autotools git-r3 python-single-r1 vala

DESCRIPTION="Service to log activities and present to other apps"
HOMEPAGE="https://launchpad.net/zeitgeist"
EGIT_REPO_URI="https://gitlab.freedesktop.org/${PN}/${PN}.git"

LICENSE="LGPL-2+ LGPL-3+ GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+datahub +downloads-monitor +fts +introspection nls sql-debug +telepathy"

REQUIRED_USE="downloads-monitor? ( datahub )"


src_prepare() {
	default
	vala_src_prepare
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable datahub) \
		$(use_enable downloads-monitor) \
		$(use_enable fts) \
		$(use_enable introspection) \
		$(use_enable nls) \
		$(use_enable sql-debug explain-queries) \
		$(use_enable telepathy)
}
