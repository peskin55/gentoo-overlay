# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta ebuild for libnemoextension"
HOMEPAGE="https://github.com/limuxmint"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 ppc x86"
IUSE=""

RDEPEND="=gnome-extra/nemo-9999
	=gnome-extra/nemo-audio-tab-9999
	=gnome-extra/nemo-compare-9999
	=gnome-extra/nemo-dropbox-9999
	=gnome-extra/nemo-emblems-9999
	=gnome-extra/nemo-extensions-9999
	=gnome-extra/nemo-fileroller-9999
	=gnome-extra/nemo-gtkhash-9999
	=gnome-extra/nemo-image-converter-9999
	=gnome-extra/nemo-media-columns-9999
	=gnome-extra/nemo-pastebin-9999
	=gnome-extra/nemo-preview-9999
	=gnome-extra/nemo-repairer-9999
	=gnome-extra/nemo-seahorse-9999
	=gnome-extra/nemo-share-9999
	=gnome-extra/nemo-terminal-9999
	=dev-python/nemo-python-9999
	media-libs/mutagen
	dev-libs/tinyxml2
	media-libs/libmediainfo
	app-text/libgxps
	media-libs/t1lib
	gnome-extra/xreader
	x11-libs/libcryptui
	dev-python/pymediainfo
	dev-python/PyPDF2
"
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
