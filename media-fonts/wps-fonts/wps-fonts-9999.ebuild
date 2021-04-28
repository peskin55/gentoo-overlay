# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font git-r3

DESCRIPTION="Fonts requested by WPS Office"
HOMEPAGE="https://github.com/IamDH4/ttf-wps-fonts"
EGIT_REPO_URI="https://github.com/IamDH4/ttf-wps-fonts.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

FONT_SUFFIX="ttf
			TTF
"
