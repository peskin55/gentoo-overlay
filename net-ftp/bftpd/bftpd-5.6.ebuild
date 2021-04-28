# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools pam tmpfiles toolchain-funcs

DESCRIPTION="Small, easy-to-configure FTP server"
HOMEPAGE="http://bftpd.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/sourceforge/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="net-ftp/ftpbase"
RDEPEND="${DEPEND}
		sys-apps/xinetd
		app-admin/logrotate
		app-admin/logrotate
		sys-libs/pam
		sys-apps/opentmpfiles
		virtual/tmpfiles
"
BDEPEND=""

S="${WORKDIR}/${PN}"


PATCHES=( "${FILESDIR}/${P}-Makefile.patch" )

src_prepare() {
	default
	rm -f "${S}/config.cache"
	rm -f "${S}/config.status"
	eautoreconf
}

src_configure() {
	"${S}/configure" \
		--prefix="${EPREFIX}"/usr \
		--mandir="${EPREFIX}"/usr/share/man \
		--infodir="${EPREFIX}"/usr/share/info \
		--datadir="${EPREFIX}"/usr/share \
		--sysconfdir="${EPREFIX}"/etc \
		--localstatedir="${EPREFIX}"/var/lib \
		--build="${CBUILD}" \
		--host="${CHOST}" \
		--target="${CTARGET}" \
		--libdir="${EPREFIX}"/usr/"$(get_libdir)" \
		--enable-libz \
		--enable-pam
}


src_compile() {
	CC=$(tc-getBUILD_CC) \
	STRINGS=$(tc-getBUILD_STRINGS) \
	STRIP=$(tc-getBUILD_STRIP) \
	OBJCOPY=$(tc-getBUILD_OBJCOPY) \
	CXX=$(tc-getBUILD_CXX) \
	LD=$(tc-getBUILD_LD) \
	AR=$(tc-getBUILD_AR) \
	AS=$(tc-getBUILD_AS) \
	CPP=$(tc-getBUILD_CPP) \
	NM=$(tc-getBUILD_NM) \
	PKG_CONFIG=$(tc-getBUILD_PKG_CONFIG) \
	RANLIB=$(tc-getBUILD_RANLIB) \
	READELF=$(tc-getBUILD_READELF) \
	CFLAGS="${BUILD_CFLAGS}" \
	CPPFLAGS="${BUILD_CPPFLAGS}" \
	CXXFLAGS="${BUILD_CXXFLAGS}" \
	LDFLAGS="${BUILD_LDFLAGS}" \
	emake
}

src_install() {
	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]] ; then
		emake DESTDIR="${D}" install
	fi
	newpamd "${FILESDIR}/${PN}.pam" "${PN}"
	newtmpfiles "${FILESDIR}/${PN}.tmpfiles" "${PN}.conf"
	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotate" "${PN}"
	insinto /etc/xinetd
	newins "${FILESDIR}/${PN}.xinetd" "${PN}"
	newinitd "${FILESDIR}/${PN}.init" "${PN}"
}
