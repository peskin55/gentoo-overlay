# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

AT_NOEAUTOMAKE="yes"

MY_PN="qBittorrent"
MY_P="${MY_PN}-release-${PV}"

DESCRIPTION="qBittorrent client"
HOMEPAGE="https://github.com/qBittorrent/qBittorrent"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/release-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dbus  debug +stacktrace +webui +X"
REQUIRED_USE="dbus? ( X )"

DOCS=( AUTHORS Changelog CONTRIBUTING.md README.md TODO )


COMMON_DEPEND="!net-p2p/qbittorrent"
RDEPEND="${COMMON_DEPEND}
	dev-libs/boost
	dev-qt/qtcore
	dev-qt/qtnetwork[ssl]
	dev-qt/qtxml
	net-libs/libtorrent-rasterbar
	sys-libs/zlib
	dev-qt/qtdbus
	X? (
		dev-libs/geoip
		dev-qt/qtgui
		dev-qt/qtsvg
		dev-qt/qtwidgets
	)"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVERBOSE_CONFIGURE="ON"
		-DSTACKTRACE=$(usex stacktrace 'ON' 'OFF')
		-DWEBUI=$(usex webui 'ON' 'OFF')
		-DGUI=$(usex X 'ON' 'OFF')
		)
		cmake_src_configure
}


pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
