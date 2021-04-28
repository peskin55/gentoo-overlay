# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Restore/upgrade firmware of iOS devices"
HOMEPAGE="https://libimobiledevice.org"
SRC_URI="https://github.com/libimobiledevice/${PN}/releases/download/${PV}/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-pda/libimobiledevice
	app-pda/libirecovery
	app-pda/libplist
	"
RDEPEND="${DEPEND}"
BDEPEND="
	net-misc/curl
	dev-libs/libzip
	dev-libs/openssl
	sys-libs/zlib
"

src_prepare() {
	default
	eautoreconf
}
