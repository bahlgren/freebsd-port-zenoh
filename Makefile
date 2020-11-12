# $FreeBSD$

PORTNAME=	zenoh
DISTVERSION=	0.5.0-beta.5
CATEGORIES=	net

MAINTAINER=	bahlgren@beah.se
COMMENT=	Eclipse zenoh: Zero Overhead Pub/sub, Store/Query and Compute

LICENSE=	EPL APACHE20
LICENSE_COMB=	dual
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS+=	rust-nightly>=1.47.0:lang/rust-nightly

USES=		cargo

USE_GITHUB=	yes
GH_ACCOUNT=	eclipse-zenoh
CARGO_BUILDDEP=	no
CARGO_BUILD_ARGS+=	--all-targets
CARGO_INSTALL_PATH=	zenoh zenoh-router plugins/zenoh-http
CARGO_INSTALL_ARGS=	--bins --examples

.include "Makefile.cargo_crates"

BINS=	z_delete z_eval z_get z_put z_put_float z_put_thr z_sub z_sub_thr \
	zenohd zn_eval zn_info zn_pub zn_pub_thr zn_pull zn_query zn_scout \
	zn_serve_sse zn_storage zn_sub zn_sub_thr zn_write

post-install:
.for b in ${BINS}
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/bin/${b}
.endfor

.include <bsd.port.mk>
