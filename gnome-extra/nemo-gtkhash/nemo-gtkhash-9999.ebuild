# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="libnemo-extension Python bindings"
HOMEPAGE="https://github.com/linuxmint"
EGIT_REPO_URI="https://github.com/linuxmint/nemo-extensions.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+nautilus +nettle +nss mhash thunar"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${P}/${PN}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--with-gtk=3.0 \
		--enable-nemo \
		$(use_enable nautilus) \
		$(use_enable thunar) \
		$(use_enable nss) \
		$(use_enable nettle) \
		$(use_enable mhash)
}
