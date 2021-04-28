# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 multilib

DESCRIPTION="Dynamic Kernel Module Support"
HOMEPAGE="https://github.com/dell/dkms"
EGIT_REPO_URI="https://github.com/dell/${PN}.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() { :; }

src_install() {
	emake \
		DESTDIR="${D}" \
		LIBDIR="${D}/usr/$(get_libdir)/${PN}" \
		INITD="${D}/etc/init.d" \
		DOCDIR="${D}/usr/share/doc/${P}" \
	install
	gzip -d "${D}/usr/share/man/man8/${PN}.8.gz"
}
