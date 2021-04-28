# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="1Password CLI"
HOMEPAGE="https://1password.com"
SRC_URI="https://cache.agilebits.com/dist/1P/op/pkg/v${PV}/op_linux_amd64_v${PV}.zip -> ${P}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	dobin "${S}/op"
}
