# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

inherit ruby-single

DESCRIPTION="A collection of tools that operate on patch files"
HOMEPAGE="http://cyberelk.net/tim/patchutils/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE="splitpatch test"
RESTRICT="!test? ( test )"

SRC_URI="http://cyberelk.net/tim/data/patchutils/stable/${P}.tar.xz
	https://github.com/benjsc/splitpatch/archive/fd2f58d04a3bbf21bd0b46d05d1fb7f5ad2b0e37.tar.gz
"
# testsuite makes use of gendiff(1) that comes from rpm, thus if the user wants
# to run tests, it should install that package as well.
DEPEND="test? ( app-arch/rpm )${RUBYDEPS}"
src_test() {
	make check || die
}

src_install() {
	default
	usex splitpatch && emake DESTDIR="${D}" -C "${WORKDIR}/splitpatch-fd2f58d04a3bbf21bd0b46d05d1fb7f5ad2b0e37" install
}
