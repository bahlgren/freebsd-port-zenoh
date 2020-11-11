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

.include <bsd.port.mk>
