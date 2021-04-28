# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="gse-sound-output-device-chooser"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A simple selector to enabled selection of sound source and sink based on Gnome Control Center"
HOMEPAGE="https://github.com/kgshank/gse-sound-output-device-chooser"
SRC_URI="https://github.com/kgshank/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror strip"
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${MY_P}"


src_configure() { :; }

src_compile() {
	ant -f "${S}/build/build.xml" create_zip
}

src_install() {
	dodir "/usr/share/gnome-shell/extensions/sound-output-device-chooser@kgshank.net"
	bsdtar xf "${S}/dist/sound-output-device-chooser@kgshank.net.zip" -C "${ED}/usr/share/gnome-shell/extensions/sound-output-device-chooser@kgshank.net"
}
