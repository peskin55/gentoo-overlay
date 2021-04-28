# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs xdg

COMMIT="daa5ea114e68afa1a0a79c87230a562eaf66d41e"

DESCRIPTION="A libpurple/Pidgin plugin for Discord"
HOMEPAGE="https://github.com/EionRobb/purple-discord"
SRC_URI="https://github.com/EionRobb/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${COMMIT}"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		DESTDIR="${D}"
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		DESTDIR="${D}" \
	install
}

