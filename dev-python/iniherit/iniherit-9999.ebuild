# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
inherit distutils-r1 git-r3

DESCRIPTION="INI File Inheritance"
HOMEPAGE="https://github.com/cadithealth/iniherit"
EGIT_REPO_URI="https://github.com/cadithealth/${PN}.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="dev-python/wheel
	dev-python/six
	dev-python/pip
"
RDEPEND="${DEPEND}"
BDEPEND=""
