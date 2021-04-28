
# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{2..3} )

inherit lua-single toolchain-funcs

DESCRIPTION="Alpine Package Keeper"
HOMEPAGE="https://pkgs.alpinelinux.org"
SRC_URI="https://git.alpinelinux.org/${PN}/snapshot/${P}.tar.xz"

LICENSE=""
SLOT="0"
IUSE="doc"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lua/lua-zlib"
RDEPEND="${DEPEND}
	${LUA_DEPS}
"
BDEPEND=""

pkg_setup() {
	lua-single_pkg_setup
}

src_prepare() {
	sed -i 's/-Werror //g' "${S}/Make.rules"
	default
}

src_compile() {
	myemakeargs=(
		VERBOSE="1"
		DESTDIR="${D}"
		CROSS_COMPILE="${CHOST}-"
		CC="$(tc-getCC)"
		AR="$(tc-getAR)"
		LD="$(tc-getLD)"
		CFLAGS="${CFLAGS}"
		LDFLAGS="${LDFLAGS}"
		SBINDIR="/usr/sbin"
		LIBDIR="/usr/$(get_libdir)"
		CONFDIR="/etc/apk"
		MANDIR="/usr/share/man"
		DOCDIR="/usr/share/doc/${P}"
		INCLUDEDIR="/usr/include"
		LUA_LIBDIR="$(lua_get_lmod_dir)"
		PKGCONFIGDIR="/usr/$(get_libdir)/pkgconfig"
	)
	emake "${myemakeargs[@]}"
	if use doc;then
		emake "${myemakeargs[@]}" docs
	fi
}

src_install() {
	myemakeargs=(
		VERBOSE="1"
		DESTDIR="${D}"
		CROSS_COMPILE="${CHOST}-"
		CC="$(tc-getCC)"
		AR="$(tc-getAR)"
		LD="$(tc-getLD)"
		CFLAGS="${CFLAGS}"
		LDFLAGS="${LDFLAGS}"
		SBINDIR="/usr/sbin"
		LIBDIR="/usr/$(get_libdir)"
		CONFDIR="/etc/apk"
		MANDIR="/usr/share/man"
		DOCDIR="/usr/share/doc/${P}"
		INCLUDEDIR="/usr/include"
		LUA_LIBDIR="$(lua_get_lmod_dir)"
		PKGCONFIGDIR="/usr/$(get_libdir)/pkgconfig"
	)
	emake "${myemakeargs[@]}" install
}
