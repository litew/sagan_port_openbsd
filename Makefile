# $OpenBSD: Makefile.template,v 1.86 2019/11/19 12:39:04 espie Exp $

COMMENT =	log analysis engine

V =		2.0.0
DISTNAME =	sagan
REVISION =	4

PKGNAME =	sagan-${V}
GH_ACCOUNT =	beave
GH_PROJECT =	sagan
GH_COMMIT =	ea5116f1f53be3949df4facb0ee1533a43f2b30d

CATEGORIES =	security

HOMEPAGE =	https://quadrantsec.com/sagan_log_analysis_engine

MAINTAINER =	litew <litew@tradiz.org>

# GPLv2
PERMIT_PACKAGE =	Yes

WANTLIB =		c m pthread pcap

MASTER_SITES =		https://github.com/beave/sagan/archive/

COMPILER =		base-clang ports-gcc

#BUILD_DEPENDS =		devel/autoconf/2.67 devel/automake/1.15

#LIB_DEPENDS =		devel/pcre>=3.0 \
#                        devel/libyaml \
#                        devel/liblognorm \
#                        net/curl \
#                        net/libmaxminddb \
#                        databases/libhiredis

SAMPLES_DIR =		${PREFIX}/share/examples/sagan

FAKE_FLAGS =		sysconfdir=${SAMPLES_DIR}

CONFIGURE_STYLE =	autoreconf
CONFIGURE_ARGS =	--enable-geoip \
                        --enable-redis \
                        --enable-libpcap \
                        --enable-system-strstr

AUTOCONF_VERSION =	2.67
AUTOMAKE_VERSION =	1.15
AUTORECONF =		./autogen.sh

SUBST_VARS =		VARBASE

post-install:
	${INSTALL_DATA_DIR} ${SAMPLES_DIR}/rules
	${INSTALL_DATA} ${WRKSRC}/etc/sagan.yaml ${SAMPLES_DIR}
#	${INSTALL_DATA} ${WRKSRC}/rules/*.rules ${SAMPLES_DIR}/rules

.include <bsd.port.mk>