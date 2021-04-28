# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit cmake python-single-r1

DESCRIPTION="Library for solving packages and reading repositories"
HOMEPAGE="https://github.com/openSUSE/libsolv"
SRC_URI="https://github.com/openSUSE/${PN}/archive/${PV}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_C_FLAGS_RELEASE="-DNDEBUG"
		-DUSE_VENDORDIRS="ON"
		-DFEDORA="1"
		-DENABLE_APPDATA="ON"
		-DENABLE_ARCHREPO="ON"
		-DENABLE_BZIP2_COMPRESSION="ON"
		-DENABLE_COMPLEX_DEPS="1"
		-DENABLE_COMPS="ON"
		-DENABLE_CONDA="ON"
		-DENABLE_CUDFREPO="ON"
		-DENABLE_DEBIAN="ON"
		-DENABLE_HAIKU="OFF"
		-DENABLE_HELIXREPO="ON"
		-DENABLE_LZMA_COMPRESSION="ON"
		-DENABLE_MDKREPO="ON"
		-DENABLE_PERL="ON"
		-DENABLE_PUBKEY="ON"
		-DENABLE_PYTHON3="ON"
		-DENABLE_RPMDB="ON"
		-DENABLE_RPMDB_BYRPMHEADER="ON"
		-DENABLE_RPMDB_LIBRPM="ON"
		-DENABLE_RPMMD="ON"
		-DENABLE_RPMPKG="ON"
		-DENABLE_RUBY="ON"
		-DENABLE_SUSEREPO="ON"
		-DENABLE_TCL="OFF"
		-DENABLE_ZCHUNK_COMPRESSION="OFF"
		-DWITH_SYSTEM_ZCHUNK="OFF"
		-DENABLE_ZSTD_COMPRESSION="ON"
		-DMULTI_SEMANTICS="ON"
		-DWITH_LIBXML2="ON"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	python_optimize
}
