# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1

DESCRIPTION="Scripts to aid in installing Arch Linux"
HOMEPAGE="https://projects.archlinux.org"
SRC_URI="https://github.com/archlinux/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-apps/pacman
	app-text/asciidoc
	!sys-fs/genfstab
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	emake V="1" PREFIX="/usr"
}

src_install() {
	dobin "${S}/arch-chroot"
	dobin "${S}/genfstab"
	dobin "${S}/pacstrap"
	doman "${S}/doc/arch-chroot.8"
	doman "${S}/doc/genfstab.8"
	doman "${S}/doc/pacstrap.8"
	newbashcomp "${S}/completion/arch-chroot.bash" "arch-chroot"
	newbashcomp "${S}/completion/genfstab.bash" "genfstab"
	newbashcomp "${S}/completion/pacstrap.bash" "pacstrap"
	insinto "/usr/share/zsh/site-functions"
	newins "${S}/completion/_archinstallscripts.zsh" "_archinstallscripts"
}
