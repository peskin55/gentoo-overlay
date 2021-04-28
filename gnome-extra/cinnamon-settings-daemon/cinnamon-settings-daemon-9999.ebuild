# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 gnome2-utils meson

DESCRIPTION="Cinnamon's settings daemon"
HOMEPAGE="https://projects.linuxmint.com/cinnamon"
EGIT_REPO_URI="https://github.com/linuxmint/${PN}.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+colord cups input_devices_wacom smartcard systemd"
RESTRICT=test

# udev is non-optional since lots of plugins, not just gudev, pull it in
RDEPEND="
	>=dev-libs/glib-2.38:2
	dev-libs/libgudev:=
	>=gnome-base/libgnomekbd-3.6
	>=gnome-extra/cinnamon-desktop-4.4:0=
	media-libs/fontconfig
	>=media-libs/lcms-2.2:2
	media-libs/libcanberra:0=[gtk3]
	>=sys-apps/dbus-1.1.2
	>=sys-auth/polkit-0.97
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.9.10:3
	>=x11-libs/libnotify-0.7.3:0=
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	>=x11-libs/libxklavier-5.0
	>=sys-power/upower-0.9.11

	colord? ( >=x11-misc/colord-0.1.27:= )
	cups? (
		>=net-print/cups-1.4[dbus]
		app-admin/system-config-printer
		net-print/cups-pk-helper )
	input_devices_wacom? (
		>=dev-libs/libwacom-0.7
		>=gnome-base/librsvg-2.36.2
		x11-drivers/xf86-input-wacom
		x11-libs/libXtst )
	smartcard? ( >=dev-libs/nss-3.11.2 )
	systemd? ( sys-apps/systemd:0= )
	!systemd? ( sys-auth/elogind:0= )
"
DEPEND="${RDEPEND}
	dev-util/gdbus-codegen
	dev-libs/libxml2:2
	>=dev-util/intltool-0.37.1
	x11-base/xorg-proto
	virtual/pkgconfig
"


src_configure() {
	# no point in disabling gudev since other plugins pull it in
	local mymesonargs=(
		-Ddbus_service_dir="${EPREFIX}/usr/share/dbus-1/services"
		-Ddbus_system_dir="${EPREFIX}/usr/share/dbus-1/system-services"
		-Duse_gudev="enabled"
		-Duse_polkit="enabled"
		-Duse_logind="enabled"
		$(meson_use colord use_color)
		$(meson_feature cups use_cups)
		$(meson_feature smartcard enable_smartcard)
	)
	meson_src_configure
}
