# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="eclass-to-manpage"
SOURCE_COMMIT="61979ff548f39d0ad6c21b448ebc06b3b6f75b21"
REPO_COMMIT="a44a7165b46889e31466b1eb876974dbbeb36899"


DESCRIPTION="Collection of Gentoo eclass manpages"
HOMEPAGE="https://github.com/mgorny/eclass-to-manpage"
SRC_URI="https://github.com/mgorny/${MY_PN}/archive/${SOURCE_COMMIT}.tar.gz -> ${PF}.tar.gz
		 https://gitweb.gentoo.org/repo/gentoo.git/snapshot/gentoo-${REPO_COMMIT}.tar.bz2 -> ${PF}-repo.tar.bz2
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="sys-apps/gawk"

S="${WORKDIR}"

src_prepare() {
	sed -i "s|VALA_MAX_API_VERSION:-0.50|VALA_MAX_API_VERSION:-0.52|g" "${S}/gentoo-${REPO_COMMIT}/eclass/vala.eclass"
	default
}

src_compile() {
	emake ECLASSDIR="${S}/gentoo-${REPO_COMMIT}/eclass" -C "${S}/${MY_PN}-${SOURCE_COMMIT}"
}

src_install() {
	emake install ECLASSDIR="${S}/gentoo-${REPO_COMMIT}/eclass" DESTDIR="${D}" PREFIX="${EPREFIX}/usr" -C "${S}/${MY_PN}-${SOURCE_COMMIT}"
}
