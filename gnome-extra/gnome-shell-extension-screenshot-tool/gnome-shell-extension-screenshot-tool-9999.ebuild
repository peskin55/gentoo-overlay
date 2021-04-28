# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Conveniently create, copy, store and upload screenshots"
HOMEPAGE="https://github.com/OttoAllmendinger/gnome-shell-screenshot"
EGIT_REPO_URI="https://github.com/OttoAllmendinger/gnome-shell-screenshot.git"

EGIT_SUBMODULES=( '*' )

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	emake -j1
}
src_install() {
	dodir "/usr/share/gnome-shell/extensions/gnome-shell-screenshot@ttll.de"
	unzip "${S}/gnome-shell-screenshot.zip" -d "${D}/usr/share/gnome-shell/extensions/gnome-shell-screenshot@ttll.de"
}
