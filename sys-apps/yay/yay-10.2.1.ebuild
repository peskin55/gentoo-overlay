# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/Jguer/go-alpm/v2 v2.0.2"
	"github.com/Jguer/go-alpm/v2 v2.0.2/go.mod"
	"github.com/Morganamilo/go-pacmanconf v0.0.0-20180910220353-9c5265e1b14f"
	"github.com/Morganamilo/go-pacmanconf v0.0.0-20180910220353-9c5265e1b14f/go.mod"
	"github.com/Morganamilo/go-srcinfo v1.0.0"
	"github.com/Morganamilo/go-srcinfo v1.0.0/go.mod"
	"github.com/bradleyjkemp/cupaloy v2.3.0+incompatible"
	"github.com/bradleyjkemp/cupaloy v2.3.0+incompatible/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/h2non/parth v0.0.0-20190131123155-b4df798d6542"
	"github.com/h2non/parth v0.0.0-20190131123155-b4df798d6542/go.mod"
	"github.com/leonelquinteros/gotext v1.4.0"
	"github.com/leonelquinteros/gotext v1.4.0/go.mod"
	"github.com/mikkeloscar/aur v0.0.0-20200113170522-1cb4e2949656"
	"github.com/mikkeloscar/aur v0.0.0-20200113170522-1cb4e2949656/go.mod"
	"github.com/nbio/st v0.0.0-20140626010706-e9e8d9816f32"
	"github.com/nbio/st v0.0.0-20140626010706-e9e8d9816f32/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210309074719-68d13333faf2"
	"golang.org/x/sys v0.0.0-20210309074719-68d13333faf2/go.mod"
	"golang.org/x/term v0.0.0-20210220032956-6a3ed077a48d"
	"golang.org/x/term v0.0.0-20210220032956-6a3ed077a48d/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/h2non/gock.v1 v1.0.15"
	"gopkg.in/h2non/gock.v1 v1.0.15/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b"
	"gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b/go.mod"
)

go-module_set_globals

DESCRIPTION="Yet Another Yogurt"
HOMEPAGE="https://github.com/Jguer/yay"
SRC_URI="https://github.com/Jguer/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz ${EGO_SUM_SRC_URI}"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	LDFLAGS="-extldflags \"${LDFLAGS}\"" \
	emake VERSION="${PV}" DESTDIR="${D}" PREFIX="/usr" GOFLAGS="-v -trimpath -modcacherw" build
}

src_install() {
	emake VERSION="${PV}" DESTDIR="${D}" PREFIX="/usr" GOFLAGS="-v -trimpath -modcacherw" install
}
