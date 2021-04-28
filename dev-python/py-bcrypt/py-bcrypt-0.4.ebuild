# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="py-bcrypt is a Python wrapper of OpenBSD's Blowfish password hashing code."
HOMEPAGE="https://code.google.com/archive/p/py-bcrypt"
SRC_URI="https://files.pythonhosted.org/packages/68/b1/1c3068c5c4d2e35c48b38dcc865301ebfdf45f54507086ac65ced1fd3b3d/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
