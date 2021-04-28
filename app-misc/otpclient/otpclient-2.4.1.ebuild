# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="OTPClient"
MY_P="${MY_PN}-${PV}"

inherit cmake xdg


DESCRIPTION="TOTP and HOTP client"
HOMEPAGE="https://github.com/paolostivanin/OTPClient"
SRC_URI="https://github.com/paolostivanin/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cli +gui +flatpak"

DEPEND="dev-libs/cotp"
RDEPEND="${DEPEND}"
BDEPEND="
		x11-libs/gtk+:3
		dev-libs/glib
		dev-libs/jansson
		dev-libs/libgcrypt
		dev-libs/libzip
		media-libs/libpng
		media-gfx/zbar
	"
	
S="${WORKDIR}/${MY_P}"
	
	
src_prepare() {
	default
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_FLATPAK_APP_FOLDER=$(usex flatpak 'ON' 'OFF')
		-DBUILD_CLI=$(usex cli 'ON' 'OFF')
		-DBUILD_GUI=$(usex gui 'ON' 'OFF')
	)
	cmake_src_configure
}
