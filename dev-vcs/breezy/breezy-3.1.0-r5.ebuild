# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6..9} )

DESCRIPTION="Bazaar is a next generation distributed version control system"
HOMEPAGE="http://bazaar-vcs.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris"
IUSE="+git test"

inherit bash-completion-r1 distutils-r1 flag-o-matic l10n
SRC_URI="https://github.com/breezy-team/${PN}/archive/${PVR/-r/-}.tar.gz -> ${PF}.tar.gz"

S="${WORKDIR}/${PF/-r/-}"
RDEPEND=""

DEPEND="|| ( dev-python/cython[${PYTHON_USEDEP}] dev-python/pyrex[${PYTHON_USEDEP}] )
		${RDEPEND}
		dev-python/pyftpdlib[${PYTHON_USEDEP}]
		dev-python/subunit[${PYTHON_USEDEP}]
		dev-python/python-fastimport[${PYTHON_USEDEP}]
		dev-python/dulwich
		dev-python/configobj[${PYTHON_USEDEP}]
		dev-python/patiencediff[${PYTHON_USEDEP}]
		dev-python/testtools[${PYTHON_USEDEP}] "

# Fails tests bug#487216
# Upstream is not exactly keen on fixing it
RESTRICT="mirror test"

python_configure() {
	esetup.py build_ext
}

python_compile() {
	distutils-r1_python_compile
}

python_test() {
	# Some tests expect the usual pyc compiling behaviour.
	local -x PYTHONDONTWRITEBYTECODE

	# Define tests which are known to fail below.
	local skip_tests="("
	# https://bugs.launchpad.net/bzr/+bug/850676
	skip_tests+="per_transport.TransportTests.test_unicode_paths.*"
	skip_tests+=")"
	if [[ -n ${skip_tests} ]]; then
		einfo "Skipping tests known to fail: ${skip_tests}"
	fi

	LC_ALL="C" "${PYTHON}" bzr --no-plugins selftest -v \
		${skip_tests:+-x} "${skip_tests}" || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	doman "${D}/usr/man/man1/brz.1"
	doman "${D}/usr/man/man1/git-remote-bzr.1"
	rm -rf "${D}/usr/man"

	# Fixup manpages manually; passing --install-data causes locales to be
	# installed in /usr/share/share/locale
#	dodir /usr/share
#	mv "${ED%/}"/usr/{man,share/man} || die

#	dodoc doc/*.txt

#[	if use doc; then
#		docinto developers
#		dodoc -r doc/developers/*
#		for doc in mini-tutorial tutorials user-{guide,reference}; do
#			docinto ${doc}
#			dodoc -r doc/en/${doc}/*
#		done
#	fi

	dobashcomp contrib/bash/brz || die
	dosym "brz" "/usr/bin/bzr"
}
