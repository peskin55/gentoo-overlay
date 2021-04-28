# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Allow to connect to paired devices from gnome control panel."
HOMEPAGE="https://github.com/bjarosze/gnome-bluetooth-quick-connect"
EGIT_REPO_URI="https://github.com/bjarosze/gnome-bluetooth-quick-connect.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_configure() { :; }

src_compile() {
	emake -C "${P}"
}

src_install() {
	insinto "/usr/share/gnome-shell/extensions/bluetooth-quick-connect@bjarosze.gmail.com"
	doins -r "${P}"
}
