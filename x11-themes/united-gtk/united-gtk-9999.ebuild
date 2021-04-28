# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="United GTK Themes"
HOMEPAGE="https://github.com/godlyranchdressing/United-GNOME"
EGIT_REPO_URI="https://github.com/godlyranchdressing/United-GNOME.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="antergos arch debian fedora +gentoo latest suse solus ubuntu +single compact both"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dodir /usr/share/themes
	bsdtar xf "${S}/United-Gentoo.tar.gz" -C "${D}/usr/share/themes"
	bsdtar xf "${S}/United-Gentoo-Compact.tar.gz" -C "${D}/usr/share/themes"
}
