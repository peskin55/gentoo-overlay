# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="HTML to Markdown converter"
HOMEPAGE="https://github.com/davidcavazos/html2md"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/pyquery"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	echo pyquery > "${S}/requirements.txt"
	default
}
