# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1

DESCRIPTION="A caching wrapper for the 1Password CLI"
HOMEPAGE="https://github.com/dcreemer/1pass"
SRC_URI="https://github.com/dcreemer/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
		app-admin/op-cli-bin
		app-misc/jq
		dev-tcltk/expect
"
RDEPEND="
		${DEPEND}
		app-shells/fzf
"
BDEPEND=""


src_install() {
	dobin "${S}/1pass"
	newbashcomp "${S}/bash_completion.sh" "${PN}"
	insinto "/usr/share/${PN}"
	doins "${S}/config.sample" "${S}/fuzzpass.sh"
	insinto "/usr/share/fish/vendor_functions.d"
	doins "${S}/fuzzpass.fish"
	dodoc "${S}/README.md" "${S}/LICENSE"
	insinto "/usr/share/emacs/site-lisp/${PN}"
	doins "${S}/1pass.el"
}
