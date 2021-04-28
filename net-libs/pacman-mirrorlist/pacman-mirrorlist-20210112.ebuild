# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Arch Linux mirror list for pacman"
HOMEPAGE="https://archlinux.org/mirrorlist"
SRC_URI="https://www.archlinux.org/mirrorlist/?country=US&protocol=http&ip_version=4 -> ${P}.txt"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="sys-apps/util-linux"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

PATCHES=( "${FILESDIR}/${P}.patch" )

src_unpack() {
	cp --dereference "${DISTDIR}/${P}.txt" "${S}"
}

src_install() {
	insinto "/etc/pacman.d"
	newins "${S}/${P}.txt" "mirrorlist"
}
	
