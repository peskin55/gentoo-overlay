# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop multilib xdg-utils unpacker

DESCRIPTION="Email Client"
HOMEPAGE="https://github.com/Foundry376/Mailspring"
SRC_URI="https://github.com/Foundry376/${PN//m/M}/releases/download/${PV}/${P}-amd64.deb -> ${P}.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip mirror"
IUSE="+libnotify"

RDEPEND="app-crypt/libsecret
	dev-vcs/git
	dev-libs/libgcrypt
	dev-libs/nss
	dev-libs/openssl
	gnome-base/gconf
	gnome-base/gnome-keyring
	gnome-base/gvfs
	virtual/libudev
	libnotify? ( x11-libs/libnotify )
	x11-libs/libXtst
	x11-misc/xdg-utils
"

S="${WORKDIR}"

src_install() {
	domenu "${S}/usr/share/applications/${PN}.desktop"
	cp -a "${S}/usr/share/${PN}" "${D}/usr/share"
	for SIZE in 16 32 64 128 256
	do
		doicon --size "${SIZE}" "${S}/usr/share/icons/hicolor/${SIZE}x${SIZE}/apps/${PN}.png"
	done
	dosym "/usr/share/${PN}/${PN}" "/usr/bin/${PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
