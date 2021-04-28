# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
PYTHON_REQ_USE="threads(+)"
DISTUTILS_OPTIONAL=true
DISTUTILS_IN_SOURCE_BUILD=true

inherit cmake distutils-r1

DESCRIPTION="C++ BitTorrent implementation focusing on efficiency and scalability"
HOMEPAGE="https://libtorrent.org https://github.com/arvidn/libtorrent"
SRC_URI="https://github.com/arvidn/libtorrent/releases/download/v${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/2.0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug +dht doc examples libressl python +ssl static-libs test"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/boost:=[threads]
	virtual/libiconv
	examples? ( !net-p2p/mldonkey )
	python? (
		${PYTHON_DEPS}
		dev-libs/boost:=[python,${PYTHON_USEDEP}]
	)
	ssl? (
		!libressl? ( dev-libs/openssl:0= )
		libressl? ( dev-libs/libressl:= )
	)
"
DEPEND="${RDEPEND}
	sys-devel/libtool
"

src_prepare() {
	cmake_src_prepare
	use python && distutils-r1_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-Ddht=$(usex dht 'ON' 'OFF')
		-Dbuild_examples=$(usex examples 'ON' 'OFF')
		-Dencryption=$(usex ssl 'ON' 'OFF')
		-Dstatic_runtime=$(usex static-libs 'ON' 'OFF')
		-Dbuild_tests=$(usex test 'ON' 'OFF')
		-Dgnutls="OFF"
		-Dbuild_tools="ON"
	)
	cmake_src_configure
	if use python
	then
		mycmakeargs+=( -Dpython-bindings="ON" -Dpython-egg-info="ON" -Dpython-install-system-dir="ON" )
		python_foreach_impl cmake_src_configure
	fi
}

src_compile() {
	cmake_src_compile

	if use python
	then
		python_foreach_impl cmake_src_compile
	fi
}

src_install() {
	use doc && HTML_DOCS+=( "${S}"/docs )

	cmake_src_install

	if use python
	then
		python_foreach_impl cmake_src_install
	fi
	find "${D}" -name '*.la' -delete || die
}
