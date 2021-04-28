# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="ninja-compatible build tool written in C"
HOMEPAGE="https://github.com/michaelforney/samurai"
SRC_URI="https://github.com/michaelforney/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		PREFIX="${EPREFIX}/usr" \
	install
}
