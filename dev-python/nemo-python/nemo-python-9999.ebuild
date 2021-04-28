# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
inherit git-r3 meson python-single-r1

DESCRIPTION="libnemo-extension Python bindings"
HOMEPAGE="https://github.com/linuxmint"
EGIT_REPO_URI="https://github.com/linuxmint/nemo-extensions.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${P}/${PN}"
