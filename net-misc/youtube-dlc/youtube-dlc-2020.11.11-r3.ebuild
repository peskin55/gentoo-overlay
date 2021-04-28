# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit bash-completion-r1 distutils-r1 readme.gentoo-r1

DESCRIPTION="Fork of youtube-dl - download videos from youtube.com or other video platforms"
HOMEPAGE="https://github.com/blackjack4494/yt-dlc"
SRC_URI="https://github.com/blackjack4494/yt-dlc/archive/${PVR/-r/-}.tar.gz -> ${PF}.tar.gz"

KEYWORDS="amd64 arm ~arm64 hppa ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"
RDEPEND="
	media-video/ffmpeg
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
	)
"
S="${WORKDIR}/yt-dlc-${PVR/-r/-}"

PATCHES=( "${FILESDIR}/${PN}-2020.10.26-completion.patch" )

src_compile() {
	emake PYTHON=/usr/bin/python3.8 pypi-files zsh-completion
	distutils-r1_src_compile
}

python_test() {
	emake offlinetest
}

python_install_all() {
	rm -rf "${D}/usr/share/zsh"
	rm -rf "${D}/usr/share/bash-completion"
	rm -rf "${D}/usr/share/fish"
	dodoc README.txt
	doman ${PN}.1

	newbashcomp ${PN}.bash-completion ${PN}

	insinto /usr/share/zsh/site-functions
	newins ${PN}.zsh _${PN}

	insinto /usr/share/fish/vendor_completions.d
	doins ${PN}.fish

	distutils-r1_python_install_all

	rm -rf "${ED}/usr/etc" || die
	rm -rf "${ED}/usr/share/doc/youtube_dlc" || die
}

pkg_postinst() {
	elog "${PN}(1) / https://bugs.gentoo.org/355661 /"
	elog "https://github.com/rg3/${PN}/blob/master/README.md#faq :"
	elog
	elog "${PN} works fine on its own on most sites. However, if you want"
	elog "to convert video/audio, you'll need ffmpeg (media-video/ffmpeg)."
	elog "On some sites - most notably YouTube - videos can be retrieved in"
	elog "a higher quality format without sound. ${PN} will detect whether"
	elog "ffmpeg is present and automatically pick the best option."
	elog
	elog "Videos or video formats streamed via RTMP protocol can only be"
	elog "downloaded when rtmpdump (media-video/rtmpdump) is installed."
	elog
	elog "Downloading MMS and RTSP videos requires either mplayer"
	elog "(media-video/mplayer) or mpv (media-video/mpv) to be installed."
	elog
	elog "If you want ${PN} to embed thumbnails from the metadata into the"
	elog "resulting MP4 files, consider installing media-video/atomicparsley"
}
