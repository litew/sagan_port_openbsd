# $OpenBSD: Makefile.template,v 1.86 2019/11/19 12:39:04 espie Exp $
#
# Replace ??? with appropriate values
# Remove extraneous comments before commit
# Use /usr/ports/infrastructure/bin/portcheck

# Reasons why the port/package shouldn't be built
#
#ONLY_FOR_ARCHS =	???
#NOT_FOR_ARCHS =	???
#COMES_WITH =		???
#BROKEN =		reason
#
# Very short description of the package (<=60 chars, usually starts lower-case)
#		|----------------------------------------------------------|
COMMENT =	log analysis engine
# COMMENT-foo =	???	for multi packages

#
# Version of port if using lang/python module
#
#MODPY_EGG_VERSION =	???

#
# What port/package will be created
#
# DISTNAME should not include suffix (like .tar.gz .tgz .tar.bz2 etc.)
SAGAN_V =	2.0.0
DISTNAME =	sagan
REVISION =	0
# PKGNAME defaults to DISTNAME unless changed
PKGNAME =	sagan-${SAGAN_V}
#PKGNAME-foo =	???	for multi packages

#
# github:
# /releases/ -> preferred. ignore GH_*, just use MASTER_SITES and DISTNAME.
# /archive/ ->  GH_ACCOUNT and GH_PROJECT, plus either GH_TAGNAME or GH_COMMIT.
#
# set DISTNAME if using GH_COMMIT, or if using GH_TAGNAME and the tag is not in
# the format "v1.00" or "1.00".
#
GH_ACCOUNT =	beave
GH_PROJECT =	sagan
#GH_TAGNAME =	1.0
GH_COMMIT =	ea5116f1f53be3949df4facb0ee1533a43f2b30d

# for any port that creates shared libraries.
# both libtool and cmake automatically set filenames based on this variable.
# for libtool- or cmake-based ports, have a look at WRKBUILD/shared_libs.log
#SHARED_LIBS =	???	0.0

# the category used in the directory name, /usr/ports/<category>/portname,
# must be included and listed first.
CATEGORIES =	security

# https preferred for HOMEPAGE
HOMEPAGE =	https://quadrantsec.com/sagan_log_analysis_engine

# person who is responsible for the port. Use a complete email address with
# a real name, e.g., "MAINTAINER = John Doe <doe57@machine.somewhere.org>".
# If you maintain several ports, use the same line each time.
# If you no longer use the port, or are unwilling/unable to handle issues
# in a timely manner, *leave the field blank*.
# Default value is ports@openbsd.org, no need to fill in
MAINTAINER =	litew <litew@tradiz.org>

# Licensing:  This determines what we can distribute through ftp.
# When you determine the license type, make sure to look at ALL distfiles.
# Every distfile can have a different license.  The PERMIT_* values are
# determined by the most restrictive license.  If you have two licenses
# that are in conflict, set PERMIT_* based on the most restrictive one.
# Make SURE you get these values right.

# Put a comment there to state what's going on.
# Can be as brief as `BSD' or `GPLv2+', but it'd better be easy to check,
# if someone wants to double-check licensing.
# For GPL, the applicable versions must be included (e.g. v2+, v2 only, v3+).
# If both PERMIT_* are Yes, just setting 'PERMIT_PACKAGE=Yes' is enough.
PERMIT_PACKAGE =	Yes
# If pledge is used, annotate with `uses pledge()' in a comment

# "make port-lib-depends-check" can help
WANTLIB =		c m pthread

# where the source files and patches can be fetched
#
MASTER_SITES =		https://github.com/beave/sagan/archive/
#MASTER_SITES =		${MASTER_SITE_SOURCEFORGE:=subdir/}
#MASTER_SITES =		${MASTER_SITE_foo:=subdir/}

# if more master sites are needed...
#MASTER_SITES0 =
# ...
#DISTFILES =		???
#EXTRACT_ONLY =		???

# Needs to be specified if tarball does not end with .tar.gz
#EXTRACT_SUFX =		.tar.bz2

# Optional subdirectory of DISTDIR where distfiles and patches will be placed
#DIST_SUBDIR =		???

# PATCHFILES are also retrieved from MASTER_SITES*
#PATCHFILES =		???
#PATCH_DIST_STRIP =	-p0

# Standard for C++ ports:
COMPILER =		base-clang
# Standard for C++11 or newer:
#COMPILER =		base-clang ports-gcc
# Ports that require a non-default compiler that do *not* use C++ should set this:
#COMPILER_LANGS =	c

# Any modules we may be using
#MODULES =		???

#
# MODPY_ settings for when using lang/python module
#
# Get source from pypi.org
#MODPY_PI =		Yes
#MODPY_SETUPTOOLS =	Yes
# If port is python3 only
#MODPY_VERSION =	${MODPY_DEFAULT_VERSION_3}

# Dependencies
BUILD_DEPENDS =		devel/autoconf/2.69 devel/automake/1.16
#RUN_DEPENDS =		???
#LIB_DEPENDS =		devel/pcre \
#                        devel/libyaml \
#                        devel/liblognorm \
#                        net/curl \
#                        net/libmaxminddb \
#                        databases/libhiredis

SAMPLES_DIR =		${PREFIX}/share/examples/sagan

#TEST_DEPENDS =		???

#MAKE_FLAGS =		???
#MAKE_ENV =		???
FAKE_FLAGS =		sysconfdir=${SAMPLES_DIR}
#TEST_FLAGS =		???

# build/configuration variables
#
#SEPARATE_BUILD =	Yes (build in a directory other than WRKSRC)
#SEPARATE_BUILD =	flavored (distinct flavors may share a common WRKSRC)
#USE_GMAKE =		Yes
#USE_GROFF =		Yes
# Programs that require GNU libtool to build instead of the OpenBSD one
# should use this option. Add a comment explaining why. Don't use this if
# a port requires libtool's .m4 files but otherwise can use OpenBSD libtool,
# in that case use "BUILD_DEPENDS=devel/libtool" instead.
#USE_LIBTOOL=		gnu
# Set CONFIGURE_STYLE to value corresponding to some standard configuration
#	  perl [modbuild]: perl's MakeMaker Makefile.PL (modbuild: perl's
#	  Module::Build Build.PL)
#	  gnu [autoconf] [old] [dest]: gnu style configure (old: no
#	  sysconfdir), (dest: add DESTDIR, does not handle it),
#	  autoconf: run autoconf to regenerate configure script. implies gnu.
#	            (see also "do-gen" target below).
#	XXX: cygnus products do NOT use autoconf for making the main
#		configure from configure.in
#	  imake [noman]: port uses imake for configuration.
#	  (noman: no man page installation)
#	  simple: port has its own configure script
#	  none: override default CONFIGURE_STYLE coming from a module
#	        (needed for some ports using lang/python, etc.)
CONFIGURE_STYLE =	autoreconf
#CONFIGURE_SCRIPT =	??? (if other than configure)
CONFIGURE_ARGS =	--enable-geoip \
                        --enable-redis \
                        --enable-libpcap \
                        --enable-bluedot \
                        --enable-system-strstr
#CONFIGURE_ENV =	???

# if debug packages are a good idea, extra configure args may be necessary
# and DEBUG_PACKAGES will commonly be set to ${BUILD_PACKAGES}
# DEBUG_CONFIGURE_ARGS =	???
# DEBUG_PACKAGES = ${BUILD_PACKAGES}

# for gnu stuff
AUTOCONF_VERSION =	2.69
AUTOMAKE_VERSION =	1.16
AUTORECONF=		./autogen.sh
# config.guess and others are copied here
#MODGNU_CONFIG_GUESS_DIRS = ??? (defaults to ${WRKSRC})

# Is the build automagic or is it interactive
#
#IS_INTERACTIVE =		Yes
#TEST_IS_INTERACTIVE =		Yes

# Assume you have one multiple choice flavor: 1 2 3 and switches a b.
# You would write
#
#FLAVORS =	1 2 3 a b
#FLAVOR ?=
# grab multiple choice value
#CHOICE = ${FLAVOR:Na:Nb}
# check that CHOICE is 1 OR 2 OR 3, or error out
#.if ${CHOICE} == "1"
# code for 1
#.elif ${CHOICE} == "2"
# code for 2
#.elif ${CHOICE} == "3"
# code for 3
#.else
#ERRORS += "Fatal: Conflicting flavor: ${FLAVOR}"
#.endif
# check for switches
#.if ${FLAVOR:Ma}
# code for a
#.endif
#.if ${FLAVOR:Mb}
# code for b
#.endif

# Things that we don't want to do for this port/package
# Generally, DON'T set anything to No if it's not needed.
# The time gained is not worth it.
#
#NO_BUILD =		Yes
#NO_TEST =		Yes

# Overrides for default values
#
#CFLAGS =		???
#LDFLAGS =		???
#MAKE_FILE =		???
#PKG_ARCH =		??? (* for arch-independent packages)
#WRKDIST =		??? if other than ${WRKDIR}/${DISTNAME}
#WRKSRC =		??? if other than ${WRKDIST}
#WRKBUILD =		??? if other than ${WRKSRC}
#WRKCONF =		??? if other than ${WRKBUILD}

#ALL_TARGET =		???
#INSTALL_TARGET =	???
#TEST_TARGET =		???

# For ports that use a script or autoreconf to generate autoconf/automake
# files (where "CONFIGURE_STYLE=autoconf" isn't enough), use some/all of these
# dependencies, and add a do-gen target:
# 
#BUILD_DEPENDS =	${MODGNU_AUTOCONF_DEPENDS} \
#			${MODGNU_AUTOMAKE_DEPENDS}
#			devel/libtool
#
SUBST_VARS =		VARBASE

post-install:
	${INSTALL_DATA_DIR} ${SAMPLES_DIR}/rules
	${INSTALL_DATA} ${WRKSRC}/etc/sagan.yaml ${SAMPLES_DIR}
#	${INSTALL_DATA} ${WRKSRC}/rules/*.rules ${SAMPLES_DIR}/rules

.include <bsd.port.mk>