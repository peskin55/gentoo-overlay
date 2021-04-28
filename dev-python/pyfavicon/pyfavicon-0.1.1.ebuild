# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )
inherit distutils-r1

DESCRIPTION="Async favicon fetcher"
HOMEPAGE="https://github.com/bilelmoussaoui/pyfavicon"
SRC_URI="https://files.pythonhosted.org/packages/df/62/5e6731cd9477096152180d826aedfa63f470b3b29c1b3b489f3d914725aa/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="dev-lang/python
		dev-python/aiohttp
		dev-python/beautifulsoup
		dev-python/pillow
"
RDEPEND="${DEPEND}"
BDEPEND=""
