# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools cmake-utils desktop qmake-utils xdg-utils git-r3

OS="Linux"
SDK_COMMIT="78f00b5488a67f3a1f90c66a0fb42acf37bec653"
MY_PN="MEGAsync"
MY_P="${MY_PN}-${PV}"
MY_PF="${MY_P}_${OS}"

DESCRIPTION="Easy automated syncing between your computers"
HOMEPAGE="https://mega.nz"
EGIT_REPO_URI="https://github.com/meganz/MEGAsync.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nautilus thunar dolphin nemo"

DEPEND="net-dns/c-ares
	dev-libs/crypto++
	dev-libs/libsodium
	dev-libs/libuv
	dev-qt/qtsvg
	dev-qt/qtx11extras
	dev-qt/qtcore
	media-libs/libmediainfo
	media-libs/libraw
	dev-qt/qtgui
	media-video/ffmpeg
"

RDEPEND="${DEPEND}
	nautilus? ( gnome-base/nautilus )
	thunar? ( xfce-base/thunar )
	dolphin? ( kde-apps/dolphin )
	nemo? ( gnome-extra/nemo )
"

BDEPEND="dev-qt/designer
	sys-apps/lsb-release
	dev-lang/swig
"

S="${WORKDIR}/${P}/src"

src_prepare() {
	default
	pushd "${S}/MEGASync/mega/" >/dev/null
	eautoreconf
	popd >/dev/null
	if use dolphin
	then
		export CMAKE_USE_DIR="${S}/MEGAShellExtDolphin"
		export BUILD_DIR="${WORKDIR}/MEGAShellExtDolphin_builddir"
		eapply "${FILESDIR}/${PN}-4.3.5.0-dolphin.patch"
		cmake-utils_src_prepare
	fi
}

src_configure() {
	pushd "${S}/MEGASync/mega/" >/dev/null
	"${S}/MEGASync/mega/configure" \
		--prefix="${S}/MEGASync/mega/bindings/qt/3rdparty" \
		--disable-shared \
		--enable-static \
		--disable-silent-rules \
		--disable-curl-checks \
		--disable-megaapi \
		--with-cryptopp \
		--host="${CHOST}" \
		--build="${CHOST}" \
		--with-sodium \
		--with-zlib \
		--with-sqlite \
		--with-cares \
		--with-curl \
		--without-freeimage \
		--with-libuv \
		--disable-posix-threads \
		--disable-examples \
		--with-libzen \
		--with-libmediainfo
	popd >/dev/null
	eqmake5
	QTCHOOSER_RUNTOOL="lrelease" \
	QT_SELECT="qt5" \
		/usr/bin/qtchooser \
			"${S}/MEGASync/MEGASync.pro"
	for USE_CONFIGURE in nautilus nemo thunar
	do
		if use "${USE_CONFIGURE}"
		then
			pushd "${S}/MEGAShellExt${USE_CONFIGURE^}" >/dev/null
			eqmake5
			popd >/dev/null
		fi
	done
	if use dolphin
	then
		export CMAKE_USE_DIR="${S}/MEGAShellExtDolphin"
		export BUILD_DIR="${WORKDIR}/MEGAShellExtDolphin_builddir"
		cmake-utils_src_configure
	fi
}

src_compile() {
	emake
	for USE_COMPILE in nautilus nemo thunar
	do
		if use "${USE_COMPILE}"
		then
			pushd "${S}/MEGAShellExt${USE_COMPILE^}" >/dev/null
			emake
			popd >/dev/null
		fi
	done
	if use dolphin
	then
		export CMAKE_USE_DIR="${S}/MEGAShellExtDolphin"
		export BUILD_DIR="${WORKDIR}/MEGAShellExtDolphin_builddir"
		cmake-utils_src_compile
	fi
}

src_install() {
	domenu "${S}/MEGASync/platform/linux/data/${PN}.desktop"
	for ICON in 16 32 48 128 256
	do
		doicon \
			--size "${ICON}" \
			--theme hicolor \
			--context apps \
				"${S}/MEGASync/platform/linux/data/icons/hicolor/${ICON}x${ICON}/apps/mega.png"
	done
	for TRAY_ICON in alert paused logging synching uptodate warning
	do
		newicon \
			--size scalable \
			--theme hicolor \
			--context status \
				"${S}/MEGASync/gui/images/${TRAY_ICON}.svg" \
					"mega${TRAY_ICON}.svg"
		insopts -m 0644
		insinto "/usr/share/icons/ubuntu-mono-dark/24/status"
		newins \
		"${S}/MEGASync/gui/images/${TRAY_ICON}_clear.svg" \
			"mega${TRAY_ICON}.svg"
	done
	dobin "${S}/MEGASync/${PN}"
	for FILES in nautilus nemo
	do
		if use "${FILES}"
		then
			pushd "${S}/MEGAShellExt${FILES^}" >/dev/null
			emake INSTALL_ROOT="${D}" install_target
			emake INSTALL_ROOT="${D}" install_emblems32
			emake INSTALL_ROOT="${D}" install_emblems64
			popd >/dev/null
		fi
	done
	if use thunar
	then
		pushd "${S}/MEGAShellExtThunar" >/dev/null
		emake INSTALL_ROOT="${D}" install
		popd >/dev/null
	fi
	if use dolphin
	then
		export CMAKE_USE_DIR="${S}/MEGAShellExtDolphin"
		export BUILD_DIR="${WORKDIR}/MEGAShellExtDolphin_builddir"
		cmake-utils_src_install
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
