# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools readme.gentoo-r1

DESCRIPTION="Mount Apple iPhone/iPod Touch file systems for backup purposes"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="https://github.com/libimobiledevice/${PN}/releases/download/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	app-pda/libimobiledevice
	app-pda/libplist
	sys-fs/fuse
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOC_CONTENTS="Only use this filesystem driver to create backups of your data.
The music database is hashed, and attempting to add files will cause the
iPod/iPhone to consider your database unauthorised.
It will respond by wiping all media files, requiring a restore through iTunes."

src_prepare() {
	default
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
