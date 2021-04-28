# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="unite-shell"
MY_P="${MY_PN}-v${PV}"

DESCRIPTION="Unite is a GNOME Shell extension which makes a few layout tweaks"
HOMEPAGE="https://github.com/hardpixel/unite-shell"
SRC_URI="https://github.com/hardpixel/${MY_PN}/releases/download/v48/${MY_P}.zip -> ${P}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	insinto "/usr/share/gnome-shell/extensions"
	doins -r "${S}/unite@hardpixel.eu"
}
