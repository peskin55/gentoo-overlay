EAPI=7

inherit git-r3 toolchain-funcs

DESCRIPTION="C program to download VoD HLS (.m3u8) files"
HOMEPAGE="https://github.com/selsta/hlsdl"
EGIT_REPO_URI="https://github.com/selsta/${PN}.git"
RESTRICT="mirror"

LICENSE=MIT
SLOT=0
KEYWORDS=amd64

DEPEND="net-misc/curl
	dev-libs/openssl"


src_compile() {
	emake \
		CC=$(tc-getBUILD_CC) \
		PREFIX="/usr" \
		INSTALL_DIR="${D}/usr/bin" \
		INSTALL_DIR_MAN="${D}/usr/share/man/man1"
}

src_install() {
	emake \
		CC=$(tc-getBUILD_CC) \
		PREFIX="/usr" \
		INSTALL_DIR="${D}/usr/bin" \
		INSTALL_DIR_MAN="${D}/usr/share/man/man1" \
		install
}
