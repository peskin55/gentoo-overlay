# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="ipynb-py-convert python module converts files: .ipynb to .py and .py to .ipynb."
HOMEPAGE="https://github.com/kiwi0fruit/ipynb-py-convert"
SRC_URI="https://files.pythonhosted.org/packages/43/90/37ff1b9f553583e60c327e1ea8cbfea469c38c9d8791ad1f7ee6d3482efa/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
