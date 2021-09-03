# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN}-browser-nightly"
MY_P="${MY_PN}-${PV}"

inherit desktop multilib rpm xdg

DESCRIPTION="Brave Web Browser"
HOMEPAGE="https://brave.com"
SRC_URI="https://github.com/${PN}/${PN}-browser/releases/download/v${PV}/${MY_P}-1.x86_64.rpm -> ${P}.rpm"

LICENSE="MPL-2.0"
RESTRICT="mirror strip"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome-keyring"

DEPEND="gnome-base/gconf:2"
RDEPEND="
	${DEPEND}
	dev-libs/libpthread-stubs
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libxshmfence
	x11-libs/libXxf86vm
	x11-libs/libXScrnSaver
	x11-libs/libXrandr
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXinerama
	dev-libs/glib
	dev-libs/nss
	dev-libs/nspr
	net-print/cups
	sys-apps/dbus
	dev-libs/expat
	media-libs/alsa-lib
	x11-libs/pango
	x11-libs/cairo
	dev-libs/gobject-introspection
	dev-libs/atk
	app-accessibility/at-spi2-core
	app-accessibility/at-spi2-atk
	x11-libs/gtk+
	x11-libs/gdk-pixbuf
	dev-libs/libpcre
	net-libs/gnutls
	sys-libs/zlib
	dev-libs/fribidi
	media-libs/harfbuzz
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/pixman
	>=media-libs/libpng-1.6.34
	media-libs/libepoxy
	dev-libs/libbsd
	dev-libs/libunistring
	dev-libs/libtasn1
	dev-libs/nettle
	dev-libs/gmp
	net-dns/libidn2
	media-gfx/graphite2
	app-arch/bzip2
"

QA_PREBUILT="usr/lib64/${PN}/${PN}"

S="${WORKDIR}"

PATCHES=( "${FILESDIR}/${PN}-1.15.40-desktop-file.patch" )

src_prepare() {
	default
	find "${S}" -type l -delete
	gzip -d "${S}/usr/share/man/man1/${MY_PN}.1.gz"
}

src_install() {
	newicon --size 128 "${S}/opt/${PN}.com/${PN}-nightly/product_logo_128_nightly.png" "${PN}.png"
	newmenu "${S}/usr/share/applications/${MY_PN}.desktop" "${PN}.desktop"
	newman "${S}/usr/share/man/man1/${MY_PN}.1" "${PN}.1"
	dodir "/usr/$(get_libdir)"
	cp -r "${S}/opt/${PN}.com/${PN}-nightly" "${D}/usr/$(get_libdir)/${PN}"
	insopts -m 0644
	insinto "/usr/share/metainfo"
	newins "${S}/usr/share/appdata/${MY_PN}.appdata.xml" "${PN}.metainfo.xml"
	insopts -m 0644
	insinto "/usr/share/gnome-control-center/default-apps"
	newins "${S}/usr/share/gnome-control-center/default-apps/${MY_PN}.xml" "${PN}.xml"
	dosym "${MY_PN}" "/usr/$(get_libdir)/${PN}/${PN}-browser"
	dosym ../"$(get_libdir)/${PN}/${MY_PN}" "/usr/bin/${PN}"
}
