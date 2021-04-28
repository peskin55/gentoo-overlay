# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN%%-*}"
MY_PV="${PV//_alpha/a}"
MY_P="${MY_PN}-${MY_PV}"

inherit desktop multilib xdg

DESCRIPTION="Firefox Nightly Web Browser"
HOMEPAGE="https://www.mozilla.org/"
RESTRICT="strip mirror"
SRC_URI="https://archive.mozilla.org/pub/firefox/nightly/latest-mozilla-central/${MY_P}.en-US.linux-x86_64.tar.bz2 -> ${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ffmpeg +pulseaudio selinux startup-notification"

DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}
	dev-libs/atk
	>=sys-apps/dbus-0.60
	>=dev-libs/dbus-glib-0.72
	>=dev-libs/glib-2.26:2
	media-libs/fontconfig
	>=media-libs/freetype-2.4.10
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf
	>=x11-libs/gtk+-2.18:2
	>=x11-libs/gtk+-3.4.0:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXt
	>=x11-libs/pango-1.22.0
	virtual/freedesktop-icon-theme
	pulseaudio? ( !<media-sound/apulse-0.1.9
		|| ( media-sound/pulseaudio media-sound/apulse ) )
	ffmpeg? ( media-video/ffmpeg )
	selinux? ( sec-policy/selinux-mozilla )
"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack "${A}"
}

src_install() {
	mkdir -p "${D}"/usr/$(get_libdir)
	cp -a "${S}" "${D}"/usr/$(get_libdir)/"${PN}"
	domenu "${FILESDIR}/${PN}.desktop"
	for SIZE in 16 32 48 64 128
	do
		newicon --size "${SIZE}" "${S}/browser/chrome/icons/default/default${SIZE}.png" "${PN}.png"
	done
	dosym ../$(get_libdir)/"${PN}"/"${MY_PN}" "/usr/bin/${PN}"
}
