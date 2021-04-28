# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Modular initramfs image creation utility"
HOMEPAGE="https://projects.archlinux.org/mkinitcpio.git"
SRC_URI="https://sources.archlinux.org/other/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -i "s|/usr/lib|/usr/$(get_libdir)|g" "${S}/Makefile"
	default
}
