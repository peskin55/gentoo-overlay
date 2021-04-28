# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="Meet a new Git Client, from the makers of Sublime Text"
HOMEPAGE="https://www.sublimemerge.com"
SRC_URI="https://download.sublimetext.com/${PN//-/_}_build_${PV//-/_}_x64.tar.xz -> ${P}.tar.xz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/${PN//-/_}

src_prepare() {
	sed -i -e '/OnlyShowIn.*/d' "${S}/${PN//-/_}.desktop"
	default
}

src_install() {
	domenu "${S}/${PN//-/_}.desktop"
	for PNG in {16,32,48,128,256}
	do
		doicon --size "${PNG}" "${S}/Icon/${PNG}x${PNG}/${PN}.png"
	done
	insinto "/opt/${PN//-/_}"
	doins -r "${S}/Icon" "${S}/Packages" "${S}/changelog.txt" "${S}/${PN//-/_}.desktop"
	exeinto "/opt/${PN//-/_}"
	doexe "${S}/crash_reporter" "${S}/git-credential-${PN%%-*}" "${S}/ssh-askpass-${PN%%-*}" "${S}/${PN//-/_}"
	echo -e '#!/bin/sh\nexec /opt/sublime_merge/sublime_merge --fwdargv0 "$0" "$@"' > "${T}/smerge"
	dobin "${T}/smerge"
}
