# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Gitlab extension utilizes the official Gitlab API to provide a comfortable overview about your projects, commits & pipelines."
HOMEPAGE="https://github.com/cinatic/gitlab-extension"
EGIT_REPO_URI="https://github.com/cinatic/gitlab-extension.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=( "${FILESDIR}/gnome-shell-extension-gitlab-extension-9999-Makefile.patch" )

src_compile() {
    emake -j1 \
        DESTDIR="${D}" \
        INSTALL_DIR="${D}/usr/share/gnome-shell/extensions/gitlab-extension@infinicode.de" \
        build
}


src_install() {
    emake -j1 \
        DESTDIR="${D}" \
        INSTALL_DIR="${D}/usr/share/gnome-shell/extensions/gitlab-extension@infinicode.de" \
        install
}
