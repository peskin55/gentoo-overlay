# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg-utils

REDIRECT="cBZjqn8dsZjft0VMZZZI85qG7Z2ZZAx7ZkZhvqJVZKJZk5ZXVZ0FZnFZyJZ1zZ3pZmzZukZW7ZN5ZEHZc0ZXB3fXZ55X7q49qVwXIS0JPmLmeuLdutrrV"

DESCRIPTION="pCloud Drive"
HOMEPAGE="https://pcloud.com"
SRC_URI="https://p-def7.${PN}.com/${REDIRECT}/${PN} -> ${P}.AppImage"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"

DEPEND="app-misc/jq
	sys-fs/fuse
"
RDEPEND="${DEPEND}"
BDEPEND=""

QA_PREBUILT="
	opt/${PN}/${PN}
	opt/${PN}/*.so
	opt/${PN}/usr/lib/*.so.*
"

S="${WORKDIR}/squashfs-root"

pkg_setup() {
	chmod +x "${DISTDIR}/${P}.AppImage"
}

src_unpack() {
	"${DISTDIR}/${P}.AppImage" --appimage-extract
}

src_prepare() {
	default
	find "${S}" -type d -exec chmod 755 {} \;
}

src_install() {
	dodir "/opt"
	rm -rf "${S}/resources/app/node_modules/ref/docs/images"
	cp -a "${S}" "${D}/opt/${PN}"
	for ICON in 16 24 32 48 64 96 128 256 512
	do
		doicon --size "${ICON}" "${S}/usr/share/icons/hicolor/${ICON}x${ICON}/apps/${PN}.png"
	done
	domenu "${FILESDIR}/${PN}.desktop"
	dosym ../../opt/"${PN}/${PN}" "/usr/bin/${PN}"
	chmod 755 "${D}/opt/${PN}"
}
