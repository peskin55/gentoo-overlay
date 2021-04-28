# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )
inherit distutils-r1 git-r3

DESCRIPTION="Open terminal with Nautilus"
HOMEPAGE="https://github.com/Stunkymonkey/nautilus-open-any-terminal"
EGIT_REPO_URI="https://github.com/Stunkymonkey/${PN}.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="gnome-base/nautilus
		dev-python/nautilus-python
		dev-python/setuptools
"
RDEPEND="${DEPEND}"
BDEPEND=""
