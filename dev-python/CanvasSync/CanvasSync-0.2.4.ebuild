# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7


PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="Simple file downloader for Canvas of Instructure."
HOMEPAGE="https://github.com/perslev/CanvasSync"
SRC_URI="https://files.pythonhosted.org/packages/b4/2d/cc0aea50715fb85671f826bab384292688f94a5338d7ff08d78ea084ac01/${P}.tar.gz"

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
