# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1 xdg-utils

DESCRIPTION="A status bar application to temporarily prevent the screensaver and the sleep powersaving mode"
HOMEPAGE="https://launchpad.net/caffeine"
SRC_URI="https://bazaar.launchpad.net/~caffeine-developers/caffeine/main/tarball/684?start_revid=684 -> ${P}.tgz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
REQUIRED_USE=${PYTHON_REQUIRED_USE}

COMMON_DEPEND="${PYTHON_DEPS}
	dev-python/ewmh
"
RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/~${PN}-developers/${PN}/main"


src_install() {
  distutils-r1_src_install
  rm -f "${D}/usr/VERSION"
  rm -f "${D}/usr/compile_translations.py"
  rm -rf "${D}/usr/share/man"
  for MANPAGE in caffein{e,ate,e-indicator}
  do
    gzip -d "${S}/share/man/man1/${MANPAGE}.1.gz"
    doman "${S}/share/man/man1/${MANPAGE}.1"
  done
}

pkg_postinst() {
  xdg_desktop_database_update
  xdg_icon_cache_update
}

pkg_postrm() {
  xdg_desktop_database_update
  xdg_icon_cache_update
}
