# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="A Python 3 module and script to retrieve and filter the latest Pacman mirror list."
HOMEPAGE="https://xyne.archlinux.ca/projects/reflector"
SRC_URI="https://xyne.archlinux.ca/projects/${PN}/src/${P}.tar.xz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
