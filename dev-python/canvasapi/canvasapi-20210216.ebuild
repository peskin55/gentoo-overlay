# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="d36d1101312e863a153ee37863a647c638f40793"

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="CanvasAPI is a Python library for accessing Instructure’s Canvas LMS API."
HOMEPAGE="https://github.com/ucfopen/canvasapi"
SRC_URI="https://github.com/ucfopen/canvasapi/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${COMMIT}"
