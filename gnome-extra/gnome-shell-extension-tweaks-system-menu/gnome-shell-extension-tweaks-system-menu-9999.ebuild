# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="Tweaks in System Menu Gnome Shell Extension"
HOMEPAGE="https://github.com/F-i-f/tweaks-system-menu"
EGIT_REPO_URI="https://github.com/F-i-f/tweaks-system-menu.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=( "${FILESDIR}/${P}-destdir.patch" )
