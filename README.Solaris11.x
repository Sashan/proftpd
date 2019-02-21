Run autoconf before attempting to configure your build.

Let configure run with option as follows:
	
CFLAGS = -I$(USRINCDIR)/kerberosv5 \
	-DHAVE_KRB5_H=1	\
	-DKRB5_DLLIMP= \
	-DHAVE__GETGRPSBYMEMBER \
	-D_SOLARIS_DTRACE

LDFLAGS =	-z now -z guidance=nolazyload -z nolazyload -lbsm

./configure 	--sysconfdir=/etc 		\
		--localstatedir=/var/run 	\
		--libexecdir=/usr/lib/proftpd	\
		--enable-ipv6			\
		--enable-ctrls			\
		--enable-facl			\
		--enable-nls			\
		--enable-dso			\
		--enable-openssl		\
		--enable-tests			\
		--disable-static		\
		--with-modules=mod_solaris_audit:mod_solaris_priv	\
		--with-shared=mod_facl:mod_wrap:mod_tls			\
		--enable-buffer-size=16384

Note: step above configures proftpd _without_ mod_gss/mod_gss_auth

Also: make sure your tool chain is set correct. especially
make sure autoconf picks up right 'nm' [1]. There are two different
nm tools installed.
	/usr/bin/nm	is a wrong one
autoconf must pick up
	/usr/gnu/bin/nm
failing to force correct nm will give a linker error as follows:
    Undefined                       first referenced
     symbol                             in file
    lt_libltdlc_LTX_preloaded_symbols   lib/libltdl/.libs/libltdlc.a(libltdlc_la-ltdl.o)
    lt__PROGRAM__LTX_preloaded_symbols  modules/mod_dso.o
    ld: fatal: symbol referencing errors
the path to correct nm tool must be set before launching configure script.

[1] https://lists.gnu.org/archive/html/libtool/2012-11/msg00008.html
