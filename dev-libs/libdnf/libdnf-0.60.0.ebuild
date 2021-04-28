# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit cmake python-single-r1

DESCRIPTION="Library providing simplified C and Python API to libsolv"
HOMEPAGE="https://github.com/rpm-software-management/libdnf"
SRC_URI="https://github.com/rpm-software-management/${PN}/archive/${PV}/${P}.tar.gz"

LICENSE=""
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-libs/libmodulemd
	dev-libs/librepo
	dev-libs/libsolv
"
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_C_FLAGS_RELEASE="-DNDEBUG"
		-DWITH_ZCHUNK=OFF
		-DCMAKE_CXX_FLAGS_RELEASE="-DNDEBUG"
		-Wno-dev
	)
	cmake_src_configure
}


src_install() {
	cmake_src_install
	python_optimize
}
