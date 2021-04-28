# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..8} )
inherit distutils-r1

DESCRIPTION="Python database schema migration tool"
HOMEPAGE="https://ollycope.com/software/yoyo/latest/"
SRC_URI="https://files.pythonhosted.org/packages/0d/5a/814d8f67d175432bb7ebb58c576aae90953176d1443dcd16b417520190f3/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="dev-python/iniherit
	dev-python/text-unidecode
	dev-python/pip
"
RDEPEND="${DEPEND}"
BDEPEND=""

