# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Arch Linux PGP keyring"
HOMEPAGE="git://git.archlinux.org/archlinux-keyring.git"
SRC_URI="https://sources.archlinux.org/other/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() { :; }

src_compile() { :; }

src_install() {
	insopts -m 0644
	insinto "/usr/share/pacman/keyrings"
	doins "${S}/archlinux"{.gpg,-{trusted,revoked}}
}


postinst() {
	/usr/bin/pacman-key --populate archlinux
	printf 'enable\nquit\n' | LANG=C \
		gpg --homedir /etc/pacman.d/gnupg \
		--no-permission-warning --command-fd 0 \
		--quiet --batch --edit-key \
		DBE7D3DD8C81D58D0A13D0E76BC26A17B9B7018A \
		2>/dev/null
}
