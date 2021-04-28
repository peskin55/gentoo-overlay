# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit git-r3

DESCRIPTION="A slightly better history for zsh"
HOMEPAGE="https://github.com/larkery/zsh-histdb"
RESTRICT="mirror"
EGIT_REPO_URI="https://github.com/larkery/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
DEPEND=""
RDEPEND="
	app-shells/zsh
	dev-db/sqlite
"

DOCS=( README.org )


src_install() {
	einstalldocs
	rm -rf "LICENSE" "${DOCS[@]}" || die
	dodir "/usr/share/zsh/plugins"
	insinto "/usr/share/zsh/plugins/${PN}"
	doins -r .
}

pkg_postinst() {
	einfo "To use this module please read the README"
}
