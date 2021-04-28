# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6..9} )

inherit git-r3 distutils-r1

DESCRIPTION="py3c helps you port C extensions to Python 3."
HOMEPAGE="https://github.com/encukou/py3c"
EGIT_REPO_URI="https://github.com/encukou/py3c.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
