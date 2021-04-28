# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Gnulib is a library of common routines intended to be shared at the source level"
HOMEPAGE="https://www.gnu.org/software/gnulib"

EGIT_REPO_URI="
	git://git.savannah.gnu.org/${PN}.git
"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+doc"

src_compile() {
	if use doc; then
		emake -C doc info html
	fi
}

src_install() {
	for DOC in README ChangeLog
	do
		dodoc "${S}/${DOC}" && rm -f "${S}/${DOC}"
	done
	cp -a "${S}" "${D}/usr/share/${PN}"

	# create and install the wrapper
	dosym ../share/${PN}/gnulib-tool /usr/bin/gnulib-tool
}
