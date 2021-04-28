# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="C library that generates TOTP and HOTP "
HOMEPAGE="https://github.com/paolostivanin/libcotp"
SRC_URI="https://github.com/paolostivanin/lib${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/libbaseencode"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/lib${P}"
