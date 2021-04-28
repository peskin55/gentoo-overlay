# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kernel-build

MY_P=linux-${PV%.*}
GENPATCHES_P=genpatches-${PV%.*}-$(( ${PV##*.} + 3 ))

DESCRIPTION="Linux kernel built with Gentoo patches"
HOMEPAGE="https://www.kernel.org/"
SRC_URI+=" https://cdn.kernel.org/pub/linux/kernel/v$(ver_cut 1).x/${MY_P}.tar.xz
	https://dev.gentoo.org/~mpagano/dist/genpatches/${GENPATCHES_P}.base.tar.xz
	https://dev.gentoo.org/~mpagano/dist/genpatches/${GENPATCHES_P}.extras.tar.xz
	"
S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="debug"
REQUIRED_USE="
	arm? ( savedconfig )
	arm64? ( savedconfig )"

RDEPEND="
	!sys-kernel/vanilla-kernel:${SLOT}
	!sys-kernel/vanilla-kernel-bin:${SLOT}
	!sys-kernel/gentoo-kernel:${SLOT}
	!sys-kernel/gentoo-kernel-bin:${SLOT}
	"
BDEPEND="
	debug? ( dev-util/dwarves )"

pkg_pretend() {
	kernel-install_pkg_pretend
}

src_prepare() {
	cat "${FILESDIR}/${PN}-5.11-config" > "${S}/.config"
	for PATCH in "${WORKDIR}"/*.patch
	do
		eapply "${PATCH}"
	done
	default
}
