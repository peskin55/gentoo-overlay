# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION=""
HOMEPAGE="https://github.com/brunonova/nautilus-admin"
EGIT_REPO_URI="git://github.com/brunonova/nautilus-admin.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="gnome-base/nautilus
	dev-python/nautilus-python
	sys-auth/polkit
	dev-util/cmake
	sys-devel/gettext
"
RDEPEND="${DEPEND}"
BDEPEND=""

