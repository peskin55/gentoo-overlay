# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_ECLASS=cmake
inherit cmake-multilib subversion

ESVN_REPO_URI="http://svn.musepack.net/libreplaygain"

DESCRIPTION="Replay Gain library from Musepack"
HOMEPAGE="https://www.musepack.net/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

src_prepare() {
	cmake_src_prepare

	sed -i -e '/CMAKE_C_FLAGS/d' CMakeLists.txt || die
}

src_install() {
	cmake-multilib_src_install
	insinto /usr/include
	doins -r include/replaygain
}
