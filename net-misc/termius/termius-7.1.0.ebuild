# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg unpacker

DESCRIPTION="Termius for Linux"
HOMEPAGE="https://termius.com"
SRC_URI="https://www.termius.com/download/linux/Termius.deb -> ${P}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

QA_PRESTRIPPED="
	opt/Termius/libEGL.so
	opt/Termius/termius-app
	opt/Termius/libffmpeg.so
	opt/Termius/libGLESv2.so
	opt/Termius/libvk_swiftshader.so
	opt/Termius/swiftshader/libEGL.so
	opt/Termius/swiftshader/libGLESv2.so
	opt/Termius/crashpad_handler
"

src_install() {
	dodir "/opt"
	cp -a "${S}/opt/${PN^}" "${D}/opt"
	domenu "${S}/usr/share/applications/${PN}-app.desktop"
	for ICON in 16 32 48 64 128 256 512
	do
		doicon --size "${ICON}" "${S}/usr/share/icons/hicolor/${ICON}x${ICON}/apps/${PN}-app.png"
	done
	dosym ../../"opt/Termius/termius-app" "/usr/bin/termius-app"
}

pkg_postinst() {
	xdg_pkg_postinst
	chmod 4755 /opt/Termius/chrome-sandbox
}

pkg_postrm() {
	xdg_pkg_postrm
}
