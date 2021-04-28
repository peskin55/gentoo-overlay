# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Displays Internet Speed"
HOMEPAGE="https://github.com/hedayaty/NetSpeed"
EGIT_REPO_URI="https://github.com/hedayaty/NetSpeed.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() { :; }

src_install() {
	emake LOCAL_INSTALL="${D}/usr/share/gnome-shell/extensions/netspeed@hedayaty.gmail.com" install
}
