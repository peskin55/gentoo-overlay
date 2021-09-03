# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils

DESCRIPTION="Display system information in GNOME Shell status bar"
HOMEPAGE="https://extensions.gnome.org/extension/3010/system-monitor-next"
SRC_URI="https://github.com/mgalgs/gnome-shell-system-monitor-applet/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	gnome-extra/gnome-system-monitor
	media-libs/clutter
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/gnome-shell-system-monitor-applet-${PV}"

src_prepare() {
	sed -i -e 's/3.32"/3.32", "3.34", "3.36", "3.38", "40"/g' "${S}/system-monitor@paradoxxx.zero.gmail.com/metadata.json"
	default
}

src_compile() { :; }

src_install() {
	insinto "/usr/share/gnome-shell/extensions"
	doins -r "${S}/system-monitor@paradoxxx.zero.gmail.com"
	fperms 755 "/usr/share/gnome-shell/extensions/system-monitor@paradoxxx.zero.gmail.com/gpu_usage.sh"
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
