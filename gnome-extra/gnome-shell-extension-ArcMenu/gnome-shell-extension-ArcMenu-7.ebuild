# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="ArcMenu"

DESCRIPTION="Arc Menu is a Gnome shell extension designed to replace the standard menu"
HOMEPAGE="https://gitlab.com/arcmenu/ArcMenu"
SRC_URI="https://gitlab.com/${MY_PN,,}/${MY_PN}/-/archive/v${PV}/${MY_PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="gnome-base/gnome-shell
    gnome-base/gnome-menus
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${MY_PN}-v${PV}"

src_compile() { :; }
