# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 desktop unpacker xdg

MY_PN="VSCodium"
DEB_ID="1617289089"

DESCRIPTION="VSCodium"
HOMEPAGE="https://github.com/vscodium/vscodium"
SRC_URI="https://github.com/${MY_PN}/${PN}/releases/download/${PV}/${PN#vs}_${PV}-${DEB_ID}_amd64.deb -> ${PF}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	dobin "${S}/usr/share/codium/bin/codium"
	rm -rf "${S}/usr/share/codium/bin"
	dodir "/usr/share/zsh/vendor-completions"
	insopts -m 0644
	insinto "/usr/share/zsh/vendor-completions"
	doins "${S}/usr/share/zsh/vendor-completions/_codium"
	insopts -m 0644
	insinto "/usr/share/metainfo"
	newins "${S}/usr/share/appdata/codium.appdata.xml" "codium.metainfo.xml"
	for MENU in codium{,-url-handler}.desktop
	do
		domenu "${S}/usr/share/applications/${MENU}"
	done
	dobashcomp "${S}/usr/share/bash-completion/completions/codium"
	for PNG in {16,22,24,32,36,48,64,72,96,128,192,256,512}
	do
		newicon --size "${PNG}" "${FILESDIR}/${PN}.${PNG}.png" "${PN}.png"
	done
	doicon --size scalable "${FILESDIR}/${PN}.svg"
	cp -R -p "${S}/usr/share/codium" "${D}/usr/share"
}
