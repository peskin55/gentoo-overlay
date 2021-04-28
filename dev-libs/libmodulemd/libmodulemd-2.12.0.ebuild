# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="C Library for manipulating module metadata files"
HOMEPAGE="https://github.com/fedora-modularity/libmodulemd"
SRC_URI="https://github.com/fedora-modularity/${PN}/releases/download/${P}/${P/libmod/mod}.tar.xz -> ${P}.tar.xz"

S="${WORKDIR}/${P/libmod/mod}"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local emesonargs=(
		-Dverbose_tests=false
		-Dwith_docs=false
	)
	meson_src_configure
}
