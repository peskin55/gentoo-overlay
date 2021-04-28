# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils xdg-utils git-r3

DESCRIPTION="A graphical grub2 settings manager"
HOMEPAGE="https://launchpad.net/grub-customizer"
EGIT_REPO_URI="git://git.launchpad.net/grub-customizer"
KEYWORDS="~amd64"

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-cpp/gtkmm:3.0
	dev-libs/openssl
	x11-themes/hicolor-icon-theme
	sys-boot/grub:2
	app-arch/libarchive
"
RDEPEND="
	${DEPEND}
"

src_install() {
	cmake-utils_src_install
	gzip -d "${D}/usr/share/man/man1/${PN}.1.gz"
}

pkg_postinst() {
		xdg_desktop_database_update
		xdg_icon_cache_update
}

pkg_postrm() {
		xdg_desktop_database_update
		xdg_icon_cache_update
}
