# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit cmake python-single-r1

DESCRIPTION="Repodata downloading library"
HOMEPAGE="https://github.com/rpm-software-management/libcomps"
SRC_URI="https://github.com/rpm-software-management/${PN}/archive/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${P}"

CMAKE_USE_DIR="${S}/${PN}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-Wno-dev
		-DPYTHON_DESIRED=3
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	python_optimize
}
