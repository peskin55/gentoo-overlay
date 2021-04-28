# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CHROMIUM_LANGS="
	am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk vi zh-CN zh-TW"

inherit chromium-2 desktop pax-utils unpacker xdg

MY_PV="${PV/_beta}"

DESCRIPTION="Password manager and secure wallet (currently in beta)"
HOMEPAGE="https://1password.com"
SRC_URI="https://onepassword.s3.amazonaws.com/linux/debian/pool/main/${PN:0:1}/${PN}/${PN}-${MY_PV}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	dev-libs/nss
	sys-auth/polkit
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver"

S="${WORKDIR}"
ONEPASSWORD_HOME="opt/1Password"
QA_PREBUILT="*"

src_prepare() {
	rm "${S}"/{debian-binary,_gpgorigin}
	pushd "${ONEPASSWORD_HOME}/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die
	gzip -d "${S}/usr/share/doc/${PN}/changelog.gz" || die
	default
}

src_install() {
	cp -R -p "${S}/opt" "${ED}"
	domenu "${S}/usr/share/applications/${PN}.desktop"
	pax-mark m "${ED}/${ONEPASSWORD_HOME}/${PN}"
	for PNG in 32 64 256 512
	do
		doicon --size "${PNG}" "${S}/usr/share/icons/hicolor/${PNG}x${PNG}/apps/${PN}.png"
	done
	dodoc "${S}/usr/share/doc/${PN}/changelog"
	dosym /"${ONEPASSWORD_HOME}/${PN}" /usr/bin/${PN}
}
