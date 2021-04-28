
# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{2..3} )

COMMIT="361eb063c6bd97751f48e10908e6beaa383ad82f"

inherit lua-single meson toolchain-funcs

DESCRIPTION="Alpine Package Keeper"
HOMEPAGE="https://pkgs.alpinelinux.org"
SRC_URI="https://git.alpinelinux.org/${PN}/snapshot/${PN}-${COMMIT}.tar.bz2 -> ${PF}.tar.bz2"

LICENSE=""
SLOT="0"
IUSE="doc"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lua/lua-zlib"
RDEPEND="${DEPEND}
	${LUA_DEPS}
"
BDEPEND=""


S="${WORKDIR}/${PN}-${COMMIT}"

pkg_setup() {
	lua-single_pkg_setup
}

src_configure() {
	local emesonargs=(
		$(meson_feature doc docs)
		-Dhelp=enabled
		-Dapk_static=false
		-Dlua=enabled
		-Dlua_version="${ELUA/lua/}"
	)
	meson_src_configure
}
