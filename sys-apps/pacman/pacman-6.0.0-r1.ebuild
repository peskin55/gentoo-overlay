# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7


inherit meson

DESCRIPTION="Archlinux's binary package manager"
HOMEPAGE="https://archlinux.org/pacman/"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.archlinux.org/pacman.git"
else
	SRC_URI="https://sources.archlinux.org/other/pacman/${P}.tar.xz"
	# Do *not* re-add ~x86!
	# https://www.archlinux.org/news/phasing-out-i686-support/
	KEYWORDS="-* ~amd64"
fi

LICENSE="GPL-2"
SLOT="0/10"

IUSE="+curl debug +doc +gpg libressl test"
COMMON_DEPEND="
	app-arch/libarchive:=[lzma]
	gpg? ( >=app-crypt/gpgme-1.4.0:= )
	curl? ( net-misc/curl )
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	virtual/libiconv
	virtual/libintl
	net-libs/pacman-mirrorlist
	app-crypt/archlinux-keyring
"
RDEPEND="${COMMON_DEPEND}"

DEPEND="${COMMON_DEPEND}
	app-text/asciidoc
	doc? ( app-doc/doxygen )
	test? (
		sys-apps/fakeroot
		sys-apps/fakechroot
	)
"

# workaround until tests are fixed/sorted out
RESTRICT="mirror test"

src_configure() {
	local emesonargs=(
		--localstatedir="${EPREFIX}/var"
		-Dbuildstatic="false"
		-Droot-dir="${EPREFIX}/"
		-Dpkg-ext=".pkg.tar.xz"
		-Dsrc-ext=".src.tar.xz"
		-Dscript-shell="/bin/sh"
		-Dldconfig="/sbin/ldconfig"
		-Dbuildscript="PKGBUILD"
		-Ddatarootdir="/usr/share"
		-Dmakepkg-template-dir="/usr/share/makepkg-template"
		-Duse-git-version="false"
		-Dcrypto="openssl"
		-Ddoc="enabled"
		$(meson_feature doc doxygen)
		$(meson_feature curl)
		$(meson_feature gpg gpgme)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
#	insinto /etc
#	doins "${FILESDIR}/${PN}.conf" "${FILESDIR}/makepkg.conf"
	keepdir "/var/cache/pacman/pkg"
	keepdir "/var/chroot/archlinux"
	keepdir "/var/lib/pacman"
}
