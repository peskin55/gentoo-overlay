# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Shows a notification when extension updates are available."
HOMEPAGE="https://github.com/franglais125/update-extensions"
EGIT_REPO_URI="https://github.com/franglais125/update-extensions.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() { :; }
