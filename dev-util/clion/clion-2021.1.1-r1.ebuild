# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="A complete toolset for C and C++ development"
HOMEPAGE="https://www.jetbrains.com/clion"
SRC_URI="https://download.jetbrains.com/cpp/CLion-${PV}.tar.gz -> ${PF}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="bindist mirror splitdebug"

BDEPEND="dev-util/patchelf"

# RDEPENDS may cause false positives in repoman.
# clion requires cmake and gdb at runtime to build and debug C/C++ projects
RDEPEND="
	app-accessibility/at-spi2-atk
	app-accessibility/at-spi2-core
	dev-libs/atk
	dev-libs/libdbusmenu
	dev-libs/nss
	dev-util/cmake
	media-libs/alsa-lib
	media-libs/freetype
	media-libs/mesa
	net-print/cups
	sys-devel/gdb
	x11-libs/libdrm
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXi
	x11-libs/libXScrnSaver
	x11-libs/libXrandr
	x11-libs/libXtst
	x11-libs/libXxf86vm
	x11-libs/pango"

QA_PREBUILT="opt/${P}/*"

src_prepare() {
	default

	local remove_me=(
		bin/gdb/linux
		bin/lldb/linux
		bin/cmake
		license/CMake*
		lib/pty4j-native/linux/aarch64
		lib/pty4j-native/linux/mips64el
		lib/pty4j-native/linux/ppc64le
	)

	use amd64 || remove_me+=( bin/fsnotifier64 lib/pty4j-native/linux/x86_64)
	use x86 || remove_me+=( bin/fsnotifier lib/pty4j-native/linux/x86)

	rm -rv "${remove_me[@]}" || die

	for file in "jbr/lib/"/{libjcef.so,jcef_helper}
	do
		if [[ -f "${file}" ]]; then
			patchelf --set-rpath '$ORIGIN' ${file} || die
		fi
	done
}

src_install() {
	local dir="/opt/${P}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}"/bin/{clion.sh,clang/linux/clang{d,-tidy}}

	if use amd64; then
		fperms 755 "${dir}"/bin/fsnotifier64
	fi
	if use arm; then
		fperms 755 "${dir}"/bin/fsnotifier-arm
	fi
	if use x86; then
		fperms 755 "${dir}"/bin/fsnotifier
	fi

	if [[ -d jbr ]]; then
		fperms 755 "${dir}"/jbr/bin/{jaotc,java,javac,jdb,jjs,jrunscript,keytool,pack200,rmid,rmiregistry,serialver,unpack200}
		# Fix #763582
		fperms 755 "${dir}"/jbr/lib/{chrome-sandbox,jcef_helper,jexec,jspawnhelper}
	fi

	doicon --size scalable "${S}/bin/${PN}.svg"
	for PNG in 16 22 24 32 36 48 64 72 96 128 192 256 512
	do
		newicon --size "${PNG}" "${FILESDIR}/${PN}.${PNG}.png" "${PN}.png"
	done
	newmenu "${FILESDIR}/jetbrains-${PN}.desktop" "${PN}.desktop"
	dosym ../.."${dir}/bin/${PN}.sh" "/usr/bin/${PN}"

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	dodir /usr/lib/sysctl.d/
	echo "fs.inotify.max_user_watches = 524288" > "${D}/usr/lib/sysctl.d/30-clion-inotify-watches.conf" || die
}
