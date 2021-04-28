# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Git Repo for Arch Linux"
HOMEPAGE="https://github.com/archlinux/asp"
EGIT_REPO_URI="https://github.com/archlinux/asp.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() { :; }


src_compile() {
	if [ -f Makefile ] || [ -f GNUmakefile ] || [ -f makefile ]; then
		emake PREFIX=/usr V=1 || die "emake failed"
	fi
}

src_install() {
	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]] ; then
		emake PREFIX=/usr V=1 DESTDIR="${D}" install
	fi

	if ! declare -p DOCS >/dev/null 2>&1 ; then
		local d
		for d in README* ChangeLog AUTHORS NEWS TODO CHANGES THANKS BUGS \
				FAQ CREDITS CHANGELOG ; do
			[[ -s "${d}" ]] && dodoc "${d}"
		done
	elif [[ $(declare -p DOCS) == "declare -a"* ]] ; then
		dodoc "${DOCS[@]}"
	else
		dodoc ${DOCS}
	fi
}


