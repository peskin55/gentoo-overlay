# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit cmake python-single-r1

DESCRIPTION="Package manager forked from Yum, using libsolv as a dependency resolver"
HOMEPAGE="https://github.com/rpm-software-management/dnf"
SRC_URI="https://github.com/rpm-software-management/${PN}/archive/${PV}/${P}.tar.gz"

LICENSE=""
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-arch/rpm
	dev-libs/libdnf
	dev-libs/libcomps
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=( "${FILESDIR}/${PN}-4.6.1-doc.patch" )

src_configure() {
	local mycmakeargs=(
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DPYTHON_DESIRED="3"
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	cmake_src_compile doc-man
}

src_install() {
	cmake_src_install
	python_fix_shebang "${D}/usr/bin"
	dosym "${PN}-3" "/usr/bin/${PN}"
	python_optimize
}
