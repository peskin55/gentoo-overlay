# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Bitwarden Command-line Interface"
HOMEPAGE="https://bitwarden.com"
SRC_URI="https://github.com/${PN%-*}/${PN##*-}/releases/download/v${PV}/bw_${PV}_amd64.snap -> ${PF}.snap"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/squashfs-root"


QA_PRESTRIPPED="
	opt/${PN}/lib/x86_64-linux-gnu/libstdc++.so.6
	opt/${PN}/lib/x86_64-linux-gnu/libgcc_s.so.1
	opt/bin/bw
"

src_unpack() {
	unsquashfs -quiet "${DISTDIR}/${PF}.snap"
}

src_install() {
	insinto "/opt/${PN}"
	doins -r "${S}"/{lib,meta}
	cat >> "${T}/bw.command-wrapper" << EOF
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/bitwarden-cli/lib:/opt/bitwarden-cli/lib/x86_64-linux-gnu"
exec "/opt/bin/bw" "\$@"
EOF
	newbin "${T}/bw.command-wrapper" "bw"
	insopts -m 0755
	insinto "/opt/bin"
	doins "${S}/bw"
}
