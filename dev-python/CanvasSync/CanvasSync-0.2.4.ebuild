# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7


PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Simple file downloader for Canvas of Instructure."
HOMEPAGE="https://github.com/perslev/CanvasSync"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/py-bcrypt[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND=""
