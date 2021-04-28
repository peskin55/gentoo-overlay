# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 xdg-utils

DESCRIPTION="A flat colorful Design icon theme"
HOMEPAGE="https://github.com/vinceliuice/Tela-circle-icon-theme"
EGIT_REPO_URI="https://github.com/vinceliuice/Tela-circle-icon-theme.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+all standard black blue brown green grey orange pink purple red yellow manjaro ubuntu"
SINGLE_THEMES=( standard black blue brown green grey orange pink purple red yellow manjaro ubuntu )

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	if use all;then
		"${S}/install.sh" -d "${WORKDIR}/themes" -a
	else
		FLAGS=()
		for i in standard black blue brown green grey orange pink purple red yellow manjaro ubuntu;do
			if use $i;then
				FLAGS+=( $i )
			fi
		done
		for THEME in "${FLAGS[@]}";do
			"${S}/install.sh" -d "${WORKDIR}/themes" "${THEME}"
		done
	fi
}

src_install() {
	dodir "/usr/share/icons"
	cd "${WORKDIR}/themes"
	for DIR in *;do
		printf "%s\n" "Copying files in the theme ${DIR}"
		cp -a "${DIR}" "${D}/usr/share/icons"
	done
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
