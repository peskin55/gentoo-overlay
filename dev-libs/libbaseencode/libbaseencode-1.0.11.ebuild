# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Library written in C for encoding and decoding data using base32 or base64"
HOMEPAGE="https://github.com/paolostivanin/libbaseencode"
SRC_URI="https://github.com/paolostivanin/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
