# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic gnome2

DESCRIPTION="GTK/Gnome interface around MPlayer"
HOMEPAGE="https://sites.google.com/site/kdekorte2/gnomemplayer"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/${PN}/${P/_beta/b}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus gda gpod musicbrainz nemo notify"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
		media-libs/gmtk
		dbus? ( dev-libs/dbus-glib )
		gda? ( gnome-extra/libgda )
		gpod? ( media-libs/libgpod )
		musicbrainz? ( media-libs/musicbrainz )
		nemo? ( gnome-extra/nemo )
		notify? ( x11-libs/libnotify )
"

S="${WORKDIR}/${P/_beta/b}"

src_prepare() {
	sed -i 's/Exec=gnome-mplayer %U/Exec=gnome-mplayer %F/' "${S}/${PN}.desktop" || die
	sed -i '/AM_GCONF_SOURCE_2/d' "${S}/configure.in" || die
	default
	eautoreconf
}

src_configure() {
	append-cflags -fcommon
	econf \
		--enable-gtk3 \
		--enable-nautilus \
		$(use_enable nemo) \
		--with-gio \
		--with-alsa \
		--with-pulseaudio \
		$(use_with dbus) \
		$(use_with notify libnotify) \
		$(use_with gpod libgpod) \
		$(use_with gda libgda) \
		$(use_with musicbrainz libmusicbrainz3)
}

src_install() {
	emake DESTDIR="${D}" install
	insinto "/usr/share/metainfo"
	newins "${FILESDIR}/${P}.metainfo.xml" "${PN}.metainfo.xml"
}

pkg_preinst() {
	gnome2_pkg_preinst
}

pkg_postinst() {
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}
