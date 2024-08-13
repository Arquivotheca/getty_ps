#! /bin/sh

# Make a new directory for the getty sources, cd to it, and run kits 1
# thru 5 through sh.  When all 5 kits have been run, read README.

echo "This is getty 2.0 kit 4 (of 5).  If kit 4 is complete, the line"
echo '"'"End of kit 4 (of 5)"'" will echo at the end.'
echo ""
export PATH || (echo "You didn't use sh, you clunch." ; kill $$)
mkdir man 2>/dev/null
echo Extracting man/gettytab.m4
sed >man/gettytab.m4 <<'!STUFFY!FUNK!' -e 's/X//'
X.\" +----------
X.\" |	$Id: gettytab.m4,v 2.0 90/09/19 20:12:26 paul Rel $
X.\" |
X.\" |	GETTYTAB man page.
X.\" |
X.\" |	Copyright 1989,1990 by Paul Sutcliffe Jr.
X.\" |
X.\" |	Permission is hereby granted to copy, reproduce, redistribute,
X.\" |	or otherwise use this software as long as: there is no monetary
X.\" |	profit gained specifically from the use or reproduction or this
X.\" |	software, it is not sold, rented, traded or otherwise marketed,
X.\" |	and this copyright notice is included prominently in any copy
X.\" |	made.
X.\" |
X.\" |	The author make no claims as to the fitness or correctness of
X.\" |	this software for any use whatsoever, and it is provided as is. 
X.\" |	Any use of this software is at the user's own risk.
X.\" |
X.\"
X.\" +----------
X.\" |	$Log:	gettytab.m4,v $
X.\" |	Revision 2.0  90/09/19  20:12:26  paul
X.\" |	Initial 2.0 release
X.\" |	
X.\" |	
X.\" 
X.\" +----------
X.\" | M4 configuration
X.\"
Xinclude(config.m4).\"
X.\"
X.\" define(`_temp_', maketemp(m4bXXXXX))
X.\" syscmd(echo _gtab_ | tr "[a-z]" "[A-Z]" | tr -d "\012" > _temp_)
X.\" define(`_GTAB_', include(_temp_))
X.\" syscmd(rm -f _temp_)
X.\"
X.\" +----------
X.\" | Manpage source follows:
X.\"
X.TH _GTAB_ _file_section_
X.SH NAME
X_gtab_ \- speed and tty settings used by getty
X.SH DESCRIPTION
XThe file
X.B _gettytab_
Xcontains information used by
X.IR getty (_mcmd_section_)
Xto set up the speed and tty settings for a line.  It supplies
Xinformation on what the
X.I login-prompt
Xshould look like.  It also supplies the speed to try next if
Xthe user indicates the current speed is not correct by typing a
X.I <break>
Xcharacter.
X.PP
XEach entry in
X.B _gettytab_
Xhas the following format:
X
X.in +.2i
X.ll 7.5i
Xlabel# initial-flags # final-flags # login-prompt #next-label
X.ll
X.in -.2i
X
XEach entry is followed by a blank line.  Lines that begin with
X.B \#
Xare ignored and may be used to comment the file.  The various
Xfields can contain quoted characters of the form
X\fB\\b\fR, \fB\\n\fR, \fB\\c\fR, etc., as well as \fB\\\fInnn\fR,
Xwhere
X.I nnn
Xis the octal value of the desired character.  The various fields are:
X.TP 16
X.I label
XThis is the string against which
X.I getty
Xtries to match its second argument. It is often the speed, such as
X.BR 1200 ,
Xat which the terminal is supposed to run, but it needn't be (see below).
X.TP
X.I initial-flags
XThese flags are the initial
X.IR ioctl (_system_section_)
Xsettings to which the terminal is to be set if a terminal type is
Xnot specified to
X.IR getty .
X.I Getty
Xunderstands the symbolic names specified in
X.B /usr/`include'/termio.h
X(see
X.\" +----------
X.\" | M4_start (trs16)
Xifdef(`trs16',
X.IR tty `('_misc_section_`)).',
X.\" | else (trs16)
X.IR termio `('_misc_section_`)).')
X.\" | M4_end (trs16)
X.\" +----------
XNormally only the speed flag is required in the
X.I initial-flags
Xfield.
X.I Getty
Xautomatically sets the terminal to raw input mode and takes care of
Xmost of the other flags.  The
X.I initial-flag
Xsettings remain in effect until
X.I getty
Xexecutes
X.IR login (_mcmd_section_).
X.TP
X.I final-flags
XThese flags take the same values as the
X.I initial-flags
Xand are set just prior to
X.I getty
Xexecutes
X.BR _login_ .
XThe speed flag is again required.  The composite flag
X.B SANE
Xtakes care of most of the other flags that need to be set so that
Xthe processor and terminal are communicating in a rational fashion.
XThe other two commonly specified
X.I final-flags
Xare
X.BR TAB3 ,
Xso that tabs are sent to the terminal as spaces, and
X.BR HUPCL ,
Xso that the line is hung up on the final close.
X.TP
X.I login-prompt
XThis entire field is printed as the
X.IR login-prompt .
XUnlike the above fields where white space is ignored (a space,
Xtab or new-line), they are included in the
X.I login-prompt
Xfield.
X
XThe
X.I login-prompt
Xmay contain various
X.BI @ char
Xand
X\fB\\\fIchar\fR
Xparameters.  These are described in full in the
X.IR getty (_mcmd_section_)
Xsection PROMPT SUBSTITUTIONS.
X.TP
X.I next-label
XThis indicates the next
X.I label
Xof the entry in the table that
X.I getty
Xshould use if the user types a
X.I <break>
Xor the input cannot be read.  Usually, a series of speeds are linked
Xtogether in this fashion, into a closed set.  For instance,
X.B 2400
Xlinked to
X.BR 1200 ,
Xwhich in turn is linked to
X.BR 300 ,
Xwhich finally is linked back to
X.BR 2400 .
X.P
XIf
X.I getty
Xis called without a
X.I speed
Xargument, then the first entry of
X.B _gettytab_
Xis used, thus making the first entry of
X.B _gettytab_
Xthe default entry. It is also used if
X.I getty
Xcan't find the specified
X.I label.
XIf
X.B _gettytab_
Xitself is missing, there is one entry built into
X.I getty
Xwhich will bring up a terminal at 9600 baud.
X.P
XIt is strongly recommended that after making or modifying
X.BR _gettytab_ `,'
Xit be run through
X.I getty
Xwith the check (\fB\-c\fR) option to be sure there are no errors.
X.SH FILES
X_gettytab_
X.SH "SEE ALSO"
Xlogin(_mcmd_section_),
Xgetty(_mcmd_section_),
Xioctl(_system_section_),
X.\" +----------
X.\" | M4_start (trs16)
Xifdef(`trs16',
Xtty`('_misc_section_`)',
X.\" | else (trs16)
Xtermio`('_misc_section_`)')
X.\" | M4_end (trs16)
X.\" +----------
!STUFFY!FUNK!
echo Extracting makedep.SH
sed >makedep.SH <<'!STUFFY!FUNK!' -e 's/X//'
X:
X# $Id: makedep.SH,v 2.0 90/09/19 20:04:37 paul Rel $
X#
X# $Log:	makedep.SH,v $
X# Revision 2.0  90/09/19  20:04:37  paul
X# Initial 2.0 release
X# 
X# 
X
Xcase $CONFIG in
X'')
X    if test ! -f config.sh; then
X	ln ../config.sh . || \
X	ln ../../config.sh . || \
X	ln ../../../config.sh . || \
X	(echo "Can't find config.sh."; exit 1)
X    fi
X    . ./config.sh
X    ;;
Xesac
Xcase "$0" in
X*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
Xesac
Xecho "Extracting makedep (with variable substitutions)"
X$spitshell >makedep <<!GROK!THIS!
X$startsh
X#
X# makedep
X#
X# Creates dependencies for Makefile
X#
X
Xexport PATH || (echo "OOPS, this isn't sh.  Desperation time.  I will feed myself to sh."; sh \$0; kill \$\$)
X
Xcat='$cat'
Xccflags='$ccflags'
Xcp='$cp'
Xcpp='$cppstdin'
Xecho='$echo'
Xegrep='$egrep'
Xexpr='$expr'
Xmv='$mv'
Xrm='$rm'
Xsed='$sed'
Xsort='$sort'
Xtest='$test'
Xtr='$tr'
Xuniq='$uniq'
X!GROK!THIS!
X
X$spitshell >>makedep <<'!NO!SUBS!'
X
X: the following weeds options from ccflags that are of no interest to cpp
Xcase "$ccflags" in
X'');;
X*)  set X $ccflags
X    ccflags=''
X    for flag do
X	case $flag in
X	-D*|-I*) ccflags="$ccflags $flag";;
X	esac
X    done
X    ;;
Xesac
X
X$cat /dev/null >.deptmp
X$rm -f *.c.c c/*.c.c
Xif test -f Makefile; then
X    mf=Makefile
Xelse
X    mf=makefile
Xfi
Xif test -f $mf; then
X    defrule=`<$mf sed -n		\
X	-e '/^\.c\.o:.*;/{'		\
X	-e    's/\$\*\.c//'		\
X	-e    's/^[^;]*;[	 ]*//p'	\
X	-e    q				\
X	-e '}'				\
X	-e '/^\.c\.o: *$/{'		\
X	-e    N				\
X	-e    's/\$\*\.c//'		\
X	-e    's/^.*\n[	 ]*//p'		\
X	-e    q				\
X	-e '}'`
Xfi
Xcase "$defrule" in
X'') defrule='$(CC) -c $(CFLAGS)' ;;
Xesac
X
Xmake clist || ($echo "Searching for .c files..."; \
X	$echo *.c | $tr ' ' '\012' | $egrep -v '\*' >.clist)
Xfor file in `$cat .clist`; do
X# for file in `cat /dev/null`; do
X    case "$file" in
X    *.c) filebase=`basename $file .c` ;;
X    *.y) filebase=`basename $file .c` ;;
X    esac
X    $echo "Finding dependencies for $filebase.o."
X    $sed -n <$file >$file.c \
X	-e "/^${filebase}_init(/q" \
X	-e '/^#/{' \
X	-e 's|/\*.*$||' \
X	-e 's|\\$||' \
X	-e p \
X	-e '}'
X    $cpp -I. $ccflags $file.c | \
X    $sed \
X	-e '/^# *[0-9]/!d' \
X	-e 's/^.*"\(.*\)".*$/'$filebase'.o: \1/' \
X	-e 's|: \./|: |' \
X	-e 's|\.c\.c|.c|' | \
X    $uniq | $sort | $uniq >> .deptmp
Xdone
X
X$sed <Makefile >Makefile.new -e '1,/^# AUTOMATICALLY/!d'
X
Xmake shlist || ($echo "Searching for .SH files..."; \
X	$echo *.SH | $tr ' ' '\012' | $egrep -v '\*' >.shlist)
Xif $test -s .deptmp; then
X    for file in `cat .shlist`; do
X	$echo `$expr X$file : 'X\(.*\).SH`: $file config.sh \; \
X	    /bin/sh $file >> .deptmp
X    done
X    $echo "Updating Makefile..."
X    $echo "# If this runs make out of memory, delete /usr/include lines." \
X	>> Makefile.new
X    $sed 's|^\(.*\.o:\) *\(.*/.*\.c\) *$|\1 \2; '"$defrule \2|" .deptmp \
X       >>Makefile.new
Xelse
X    make hlist || ($echo "Searching for .h files..."; \
X	$echo *.h | $tr ' ' '\012' | $egrep -v '\*' >.hlist)
X    $echo "You don't seem to have a proper C preprocessor.  Using grep instead."
X    $egrep '^#include ' `cat .clist` `cat .hlist`  >.deptmp
X    $echo "Updating Makefile..."
X    <.clist $sed -n							\
X	-e '/\//{'							\
X	-e   's|^\(.*\)/\(.*\)\.c|\2.o: \1/\2.c; '"$defrule \1/\2.c|p"	\
X	-e   d								\
X	-e '}'								\
X	-e 's|^\(.*\)\.c|\1.o: \1.c|p' >> Makefile.new
X    <.hlist $sed -n 's|\(.*/\)\(.*\)|s= \2= \1\2=|p' >.hsed
X    <.deptmp $sed -n 's|c:#include "\(.*\)".*$|o: \1|p' | \
X       $sed 's|^[^;]*/||' | \
X       $sed -f .hsed >> Makefile.new
X    <.deptmp $sed -n 's|c:#include <\(.*\)>.*$|o: /usr/include/\1|p' \
X       >> Makefile.new
X    <.deptmp $sed -n 's|h:#include "\(.*\)".*$|h: \1|p' | \
X       $sed -f .hsed >> Makefile.new
X    <.deptmp $sed -n 's|h:#include <\(.*\)>.*$|h: /usr/include/\1|p' \
X       >> Makefile.new
X    for file in `$cat .shlist`; do
X	$echo `$expr X$file : 'X\(.*\).SH`: $file config.sh \; \
X	    /bin/sh $file >> Makefile.new
X    done
Xfi
X$rm -f Makefile.old
X$cp Makefile Makefile.old
X$cp Makefile.new Makefile
X$rm Makefile.new
X$echo "# WARNING: Put nothing here or make depend will gobble it up!" >> Makefile
X$rm -f .deptmp `sed 's/\.c/.c.c/' .clist` .shlist .clist .hlist .hsed
X
X!NO!SUBS!
X$eunicefix makedep
Xchmod +x makedep
Xcase `pwd` in
X*SH)
X    $rm -f ../makedep
X    ln makedep ../makedep
X    ;;
Xesac
!STUFFY!FUNK!
echo Extracting config.h.SH
sed >config.h.SH <<'!STUFFY!FUNK!' -e 's/X//'
X:
X# $Id: config.h.SH,v 2.0 90/09/19 19:37:01 paul Rel $
X#
X# Creates config.h file for getty distribution
X#
X# $Log:	config.h.SH,v $
X# Revision 2.0  90/09/19  19:37:01  paul
X# Initial 2.0 release
X# 
X#
X
Xcase $CONFIG in
X'')
X    if test ! -f config.sh; then
X	ln ../config.sh . || \
X	ln ../../config.sh . || \
X	ln ../../../config.sh . || \
X	(echo "Can't find config.sh."; exit 1)
X    fi
X    . config.sh
X    ;;
Xesac
Xcase "$0" in
X*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
Xesac
X
Xcase "$d_phostname" in
X$define) phostname='\"$phostname\"' ;;
X$undef)  phostname='' ;;
Xesac
X
Xecho "Extracting config.h (with variable substitutions)"
X$spitshell >config.h <<!GROK!THIS!
X/*
X**	config.h
X**
X**	Getty configuration.
X*/
X
X/*
X**	Copyright 1989,1990 by Paul Sutcliffe Jr.
X**
X**	Permission is hereby granted to copy, reproduce, redistribute,
X**	or otherwise use this software as long as: there is no monetary
X**	profit gained specifically from the use or reproduction or this
X**	software, it is not sold, rented, traded or otherwise marketed,
X**	and this copyright notice is included prominently in any copy
X**	made.
X**
X**	The author make no claims as to the fitness or correctness of
X**	this software for any use whatsoever, and it is provided as is. 
X**	Any use of this software is at the user's own risk.
X*/
X
X
X#include "tune.h"			/* defs needed below */
X
X
X/*  These are set by config.sh.
X *  If you change them here, they will be reset
X *  the next time you run Configure.
X */
X
X#$d_portable	PORTABLE		/* compile for more than one site */
X#$d_getutent	GETUTENT		/* we have getutent() and friends */
X#$d_strdup	STRDUP			/* we have strdup() */
X#$d_putenv	PUTENV			/* we have putenv() */
X
X#$d_ttytype	TTYTYPE   "$ttytype"	/* file used to identify terminals */
X#$define	GETTYTAB  "$gettytab"	/* file used for speed/termio table */
X
X#$define	STDCHAR   $stdchar	/* signed or unsigned chars in stdio */
X#$define	UIDTYPE	  $uidtype	/* storage type of UID's */
X#$define	GIDTYPE	  $gidtype	/* storage type of GID's */
X
X#$d_fcntl	FCNTL			/* include fcntl.h? */
X#$d_ioctl	IOCTL			/* include sys/ioctl.h? */
X#$i_pwd		PWD			/* include pwd.h? */
X#$i_time	I_TIME			/* include time.h? */
X#$i_systime	I_SYSTIME		/* include sys/time.h? */
X#$d_systimekernel	SYSTIMEKERNEL
X#$d_varargs	VARARGS			/* include varargs.h? */
X
X#$d_index	index	  strchr	/* use these instead */
X#$d_index	rindex	  strrchr
X
X#$d_voidsig	VOIDSIG			/* you have 'void (*signal)()' */
X
X#ifdef	VOIDSIG				/* define sig_t appropriately */
Xtypedef	void	sig_t;
X#else	/* VOIDSIG */
Xtypedef	int	sig_t;
X#endif	/* VOIDSIG */
X
X#ifndef	VOIDUSED
X#$define	VOIDUSED  $defvoidused
X#endif	/* VOIDUSED */
X#$define	VOIDFLAGS $voidflags
X#if (VOIDFLAGS & VOIDUSED) != VOIDUSED
X#$define	void	  int		/* is void to be avoided? */
X#$define	M_VOID			/* Xenix strikes again */
X#endif	/* VOIDFLAGS & VOIDUSED */
X
X#ifndef	PORTABLE
X#$define	HOSTNAME  "$hostname"	/* compile node name in */
X#else	/* PORTABLE */
X#$d_douname	DOUNAME			/* use uname() to get node name */
X#$d_phostname	PHOSTNAME $phostname	/* get node name from this command */
X#endif	/* PORTABLE */
X
X#ifndef	UTMP_FILE
X#$define	UTMP_FILE "$utmp"	/* name of the utmp file */
X#endif	/* UTMP_FILE */
X
X#ifdef	LOGUTMP
X#ifndef	WTMP_FILE
X#$define	WTMP_FILE "$wtmp"	/* name of the wtmp file */
X#endif	/* WTMP_FILE */
X#endif	/* LOGUTMP */
X
X#ifdef	TRYMAIL
X#$define	MAILER	  "$mailer"	/* mail agent */
X#endif	/* TRYMAIL */
X
X#ifdef	UUGETTY
X#$d_asciipid	ASCIIPID		/* PID stored in ASCII in lock file */
X#$define	LOCK	  "$lock/LCK..%s"	/* lock file name */
X#$define	UUCPID	  $uucpid	/* uid of UUCP account */
X#endif	/* UUGETTY */
X
X
X/* end of config.h */
X!GROK!THIS!
Xchmod 644 config.h
X$eunicefix config.h
!STUFFY!FUNK!
echo Extracting Makefile.SH
sed >Makefile.SH <<'!STUFFY!FUNK!' -e 's/X//'
X:
X# $Id: Makefile.SH,v 2.0 90/09/19 19:28:46 paul Rel $
X#
X# Creates Makefile for getty distribution
X#
X# $Log:	Makefile.SH,v $
X# Revision 2.0  90/09/19  19:28:46  paul
X# Initial 2.0 release
X# 
X# 
X
Xcase $CONFIG in
X'')
X    if test ! -f config.sh; then
X	ln ../config.sh . || \
X	ln ../../config.sh . || \
X	ln ../../../config.sh . || \
X	(echo "Can't find config.sh."; exit 1)
X    fi
X    . config.sh
X    ;;
Xesac
Xcase "$0" in
X*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
Xesac
X
X: add necessary modules based on config.sh
Xcase "$d_getutent" in
X"$define")
X    src=""
X    obj=""
X    ;;
X"$undef")
X    src="getutent.c"
X    obj="getutent.o"
X    ;;
Xesac
Xcase "$d_strdup" in
X"$undef")
X    src="$src strdup.c"
X    obj="$obj strdup.o"
X    ;;
Xesac
Xcase "$d_putenv" in
X"$undef")
X    src="$src putenv.c"
X    obj="$obj putenv.o"
X    ;;
Xesac
X
Xecho "Extracting Makefile (with variable substitutions)"
X$spitshell >Makefile <<!GROK!THIS!
X#
X# Makefile for getty distribution
X#
X# To recreate this file, make any changes in config.sh and then
X# say "sh Makefile.SH"
X#
X
XSHELL=	/bin/sh
X
X# compiler stuff -- check these
XCC=	$cc
XCFLAGS=	$optimize $ccflags $small
XLFLAGS=	$ldflags $split
XLIBS=	$libs
XLINT=	lint -abchuvx
XLLIBS=	$llib_termlib
X
X# where things go
XBIN=	$bin
XUUBIN=	$bin
X
X# what are we making
XSH=	Makefile.SH config.h.SH makedep.SH
XHDRS=	config.h defaults.h extern.h funcs.h getty.h patchlevel.h \\
X	table.h tune.h
XSRC=	main.c funcs.c defaults.c table.c $src
XOBJ=	main.o funcs.o defaults.o table.o $obj
XUUSRC=	umain.c funcs.c defaults.c table.c $src
XUUOBJ=	umain.o funcs.o defaults.o table.o $obj
X
X# rules
X
Xall:	getty uugetty manpages
X
Xclist:
X	@echo $(SRC) $(UUSRC) | $tr ' ' '\012' | $sort | $uniq > .clist
X
Xhlist:
X	@echo $(HDRS) | $tr ' ' '\012' > .hlist
X
Xshlist:
X	@echo $(SH) | $tr ' ' '\012' > .shlist
X!GROK!THIS!
X$spitshell >>Makefile <<'!NO!SUBS!'
X
Xgetty:	$(OBJ)
X	$(CC) $(LFLAGS) -o $@ $(OBJ) $(LIBS) 
X
Xuugetty: $(UUOBJ)
X	$(CC) $(LFLAGS) -o $@ $(UUOBJ) $(LIBS) 
X
Xmanpages:
X	cd man; make
X
Xinstall: getty uugetty
X	-mv $(BIN)/getty $(BIN)/getty-
X	-mv $(UUBIN)/uugetty $(UUBIN)/uugetty-
X	cp getty $(BIN)
X	cp uugetty $(UUBIN)
X	chmod 700 $(BIN)/getty $(UUBIN)/uugetty
X	strip $(BIN)/getty $(UUBIN)/uugetty
X	cd man; make install
X
Xlint:	$(SRC) umain.c
X	@echo "linting getty sources..."
X	echo "GETTY" >lint.out
X	$(LINT) $(SRC) $(LLIBS) >>lint.out
X	@echo "linting uugetty sources..."
X	@echo '' >>lint.out
X	echo 'UUGETTY' >>lint.out
X	$(LINT) -DUUGETTY $(UUSRC) $(LLIBS) >>lint.out
X	@echo "lint output is in lint.out"
X
Xclean:
X	rm -f umain.c *.o core *.out .*list *.ln Makefile.old
X	cd man; make clean
X
Xclobber: clean
X	rm -f getty uugetty
X	cd man; make clobber
X
Xrealclean: clobber
X
Xdepend:	makedep umain.c tune.h
X	chmod +x makedep
X	./makedep
X
X# special dependancies follow
X
Xumain.c: main.c
X	-ln main.c umain.c
X
Xumain.o:
X	$(CC) $(CFLAGS) -DUUGETTY -c umain.c
X
Xtune.h:	tune.H
X	@echo "------------------------------------------------"
X	@echo "Making a tune.h from the tune.H prototype file. "
X	@echo "You may wish to edit tune.h before making getty."
X	@echo "------------------------------------------------"
X	-cp tune.H tune.h
X
X# AUTOMATICALLY GENERATED MAKE DEPENDENCIES--PUT NOTHING BELOW THIS LINE
X!NO!SUBS!
Xchmod 644 Makefile
X$eunicefix Makefile
!STUFFY!FUNK!
echo Extracting man/makeconfig
sed >man/makeconfig <<'!STUFFY!FUNK!' -e 's/X//'
X:
X#
X# $Id: makeconfig,v 2.0 90/09/19 20:13:46 paul Rel $
X#
X# $Log:	makeconfig,v $
X# Revision 2.0  90/09/19  20:13:46  paul
X# Initial 2.0 release
X# 
X#
X
Xcase $CONFIG in
X'')
X    if test ! -f config.sh; then
X	ln ../config.sh . || \
X	ln ../../config.sh . || \
X	ln ../../../config.sh . || \
X	(echo "Can't find config.sh."; exit 1)
X    fi
X    . config.sh
X    ;;
Xesac
Xcase "$0" in
X*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
Xesac
X
Xtmp=/tmp/mc$$
Xrmlist="$tmp"
Xtrap 'echo " "; $rm -f $rmlist; exit 1' 1 2 3
X
X: where is the source
Xsrc=..
Xtune=$src/tune.h
Xrelease=$src/release.h
X
X: is package complete
Xif $test ! -f $tune; then
X    echo "Can't find tune.h."
X    exit 1
Xfi
X
X: things we can tell from tune.h
Xcppout=".cppout"
Xtuneout=".tune"
Xrmlist="$cppout $tuneout $rmlist"
X$cppstdin -I$src -I. $cppminus <<EOS >$cppout
X#include <$tune>
X#include <$release>
Xconsole=CONSOLE
Xdefaults=DEFAULTS
Xissue=ISSUE
Xlogin=LOGIN
Xconnect=DEF_CONNECT
X#ifdef	LOGUTMP
Xlogutmp="$define"
X#endif
X#ifdef	TRS16
Xtrs16="$define"
X#endif
X#ifdef	TRYMAIL
Xtrymail="$define"
Xnotify=NOTIFY
X#endif
X#ifdef	WARNCASE
Xwarncase="$define"
X#endif
Xrelease=RELEASE
Xdate=DATE
XEOS
X$sed 's/[ 	]//' <$cppout >$tuneout
Xchmod +x $tuneout
X. $tuneout
X
Xdefaults=`$echo $defaults | $sed 's;/\%s;;'`
X$sed 's;\\;\\\\;g' <<EOS >$tmp
X$connect
XEOS
Xconnect=`cat $tmp`
X
X: things we cannot tell from tune.h
Xif $test ! -d /usr/lib/terminfo; then
X    termcap="$define"
Xfi
Xsystems=L.sys
Xif $test -f /usr/lib/uucp/Systems; then
X    systems=Systems
Xfi
Xgtab=`basename $gettytab`
X
X: name the man pages
Xcase "$xenix" in
X"$define")
X    cmd=C; mcmd=M; system=S; library=S; file=F; misc=M
X    ;;
X"$undef")
X    cmd=1; mcmd=1m; system=2; library=3; file=4; misc=7
X    ;;
Xesac
X
X$cat <<EOC >config.m4
X.\" +----------
X.\" | local GETTY configurations
X.\"
X.\" define(\`_cmd_section_', $cmd)
X.\" define(\`_mcmd_section_', $mcmd)
X.\" define(\`_system_section_', $system)
X.\" define(\`_library_section_', $library)
X.\" define(\`_file_section_', $file)
X.\" define(\`_misc_section_', $misc)
X.\" define(\`_console_', $console)
X.\" define(\`_defaults_', $defaults)
X.\" define(\`_gettytab_', $gettytab)
X.\" define(\`_gtab_', $gtab)
X.\" define(\`_issue_', $issue)
X.\" define(\`_login_', $login)
X.\" define(\`_utmp_', $utmp)
X.\" define(\`_wtmp_', $wtmp)
X.\" define(\`_systems_', $systems)
X.\" define(\`_connect_', $connect)
X.\" define(\`RELEASE', $release)
X.\" define(\`DATE', $date)
X.\"
XEOC
X
Xcase "$logutmp" in
X"$define") $cat <<EOC >>config.m4
X.\" define(\`logutmp')
XEOC
X;;
Xesac
Xcase "$termcap" in
X"$define") $cat <<EOC >>config.m4
X.\" define(\`termcap')
XEOC
X;;
Xesac
Xcase "$trs16" in
X"$define") $cat <<EOC >>config.m4
X.\" define(\`trs16')
XEOC
X;;
Xesac
Xcase "$trymail" in
X"$define") $cat <<EOC >>config.m4
X.\" define(\`trymail')
X.\" define(\`_notify_', $notify)
XEOC
X;;
Xesac
Xcase "$ttytype" in
X"/*") $cat <<EOC >>config.m4
X.\" define(\`ttytype', $ttytype)
XEOC
X;;
Xesac
Xcase "$warncase" in
X"$define") $cat <<EOC >>config.m4
X.\" define(\`warncase')
XEOC
X;;
Xesac
X
X$rm -f $rmlist
X# grrr, don't ask
X$rm -f $cppout
X$rm -f $tuneout
!STUFFY!FUNK!
echo Extracting man/getutent.m4
sed >man/getutent.m4 <<'!STUFFY!FUNK!' -e 's/X//'
X.\" +----------
X.\" |	$Id: getutent.m4,v 2.0 90/09/19 20:12:55 paul Rel $
X.\" |
X.\" |	GETUTENT man page.
X.\" |
X.\" |	Copyright 1989,1990 by Paul Sutcliffe Jr.
X.\" |
X.\" |	Permission is hereby granted to copy, reproduce, redistribute,
X.\" |	or otherwise use this software as long as: there is no monetary
X.\" |	profit gained specifically from the use or reproduction or this
X.\" |	software, it is not sold, rented, traded or otherwise marketed,
X.\" |	and this copyright notice is included prominently in any copy
X.\" |	made.
X.\" |
X.\" |	The author make no claims as to the fitness or correctness of
X.\" |	this software for any use whatsoever, and it is provided as is. 
X.\" |	Any use of this software is at the user's own risk.
X.\" |
X.\"
X.\" +----------
X.\" |	$Log:	getutent.m4,v $
X.\" |	Revision 2.0  90/09/19  20:12:55  paul
X.\" |	Initial 2.0 release
X.\" |	
X.\" |	
X.\" 
X.\" +----------
X.\" | M4 configuration
X.\"
Xinclude(config.m4).\"
X.\"
X.\" +----------
X.\" | Manpage source follows:
X.\"
X.TH GETUTENT _library_section_
X.SH NAME
Xgetutent, getutline, setutent, endutent,
Xutmpname \- access utmp file entry
X.SH SYNOPSIS
X.B \#include <utmp.h>
X
X.B struct utmp *getutent();
X
X.B struct utmp *getutline(\fIline\fB)\fR;
X.br
X.B struct utmp *\fIline\fR;
X
X.B void setutent();
X
X.B void endutent();
X
X.B void utmpname(\fIfile\fB)\fR;
X.br
X.B char *\fIfile\fR;
X.SH DESCRIPTION
X.I Getutent
Xand
X.I getutline
Xeach return a pointer to a structure of the following type:
X.nf
X
X    struct utmp {
X	    char	ut_line[8];        /* tty name */
X	    char	ut_name[8];        /* user id */
X	    long	ut_time;           /* time on */
X    };
X
X.fi
X.I Getutent
Xreads in the next entry from a
X.IR utmp \-like
Xfile.  If the file is not already open, it opens it.  If it
Xreaches the end of file, it fails.
X.PP
X.I Getutline
Xsearches forward from the current point in the
X.I utmp
Xfile until it finds an entry which has a
X.I ut_line
Xstring matching the
X.I line\->ut_line
Xstring.  If the end of file is reached without a match, it fails.
X.PP
X.I Setutent
Xresets the input stream to the beginning of the file.  This should be
Xdone before each search for a new entry if it is desired that the
Xentire file be examined.
X.PP
X.I Endutent
Xcloses the currently open file.
X.PP
X.I Utmpname
Xallows the user to change the name of the file examined, from
X.B _utmp_
Xto any other file.  It is most often expected that this other file
Xwill be
X.BR _wtmp_ .
XIf the file does not exist, this will not be apparent until the first
Xattempt to reference the file is made.
X.I Utmpname
Xdoes not open the file.  It just closes the old file if it is
Xcurrently open and saves the new file name.
X.SH FILES
X_utmp_
X.br
X_wtmp_
X.SH BUGS
XThe most current entry is saved in a static structure.  Multiple
Xaccesses require that it be copied before further accesses are made.
X.PP
XThese routines use buffered standard I/O for input.
X.SH "SEE ALSO"
Xutmp(_file_section_)
X.SH AUTHOR
X.nf
XPaul Sutcliffe, Jr.  <paul at devon.lns.pa.us>
XUUCP: ...!rutgers!devon!paul
!STUFFY!FUNK!
echo Extracting tune.H
sed >tune.H <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: tune.H,v 2.0 90/09/19 20:19:47 paul Rel $
X**
X**	Getty tuneable parameters.
X*/
X
X/*
X**	Copyright 1989,1990 by Paul Sutcliffe Jr.
X**
X**	Permission is hereby granted to copy, reproduce, redistribute,
X**	or otherwise use this software as long as: there is no monetary
X**	profit gained specifically from the use or reproduction or this
X**	software, it is not sold, rented, traded or otherwise marketed,
X**	and this copyright notice is included prominently in any copy
X**	made.
X**
X**	The author make no claims as to the fitness or correctness of
X**	this software for any use whatsoever, and it is provided as is. 
X**	Any use of this software is at the user's own risk.
X*/
X
X/*
X**	$Log:	tune.H,v $
X**	Revision 2.0  90/09/19  20:19:47  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X#define	boolean	 int			/* does your cc know about boolean? */
X
X#define	DEF_CFL	 (CS7 | PARENB)		/* default word-len/parity */
X
X#define	DEF_CONNECT  "CONNECT\s\A\r\n"	/* default CONNECT string */
X
X
X/*  Feature selection
X */
X
X#undef	DEBUG				/* include debugging code */
X#define	LOGUTMP				/* need to update utmp/wtmp files */
X#define	MY_CANON			/* use my own ERASE and KILL chars */
X#define	RCSID				/* include RCS ID info in objects */
X#define	SETTERM				/* need to set TERM in environment */
X#define	TELEBIT				/* include Telebit FAST parsing */
X#define	TRYMAIL				/* mail errors if CONSOLE unavailable */
X#define	WARNCASE			/* warn user if login is UPPER case */
X
X/*  define your ERASE and KILL characters here
X */
X#ifdef	MY_CANON
X#define	MY_ERASE '\010'			/* 010 = ^H, backspace */
X#define	MY_KILL	 '\025'			/* 025 = ^U, nak */
X#endif
X
X/*  define your Telebit FAST speed here
X */
X#ifdef	TELEBIT
X#define	TB_FAST	 "19200"		/* CONNECT FAST == this speed */
X#endif	/* TELEBIT */
X
X/*  who should be notified of errors?
X */
X#ifdef	TRYMAIL
X#define	NOTIFY	 "root"
X#endif
X
X
X/*  Where to find things
X */
X
X#define	CONSOLE	 "/dev/console"		/* place to log errors */
X#define	DEFAULTS "/etc/default/%s"	/* name of defaults file */
X#define	ISSUE	 "/etc/issue"		/* name of the issue file;
X					   say "#undef ISSUE" to turn off
X					   the issue feature */
X#define	LOGIN	 "/bin/login"		/* name of login program */
X
X
X/*  Special cases
X */
X
X#undef	TRS16				/* you are a Tandy 6000 or equivilent */
X
X
X/*  You probably shouldn't fool with these
X */
X
X#define	MAXDEF	 100			/* max # lines in defaults file */
X#define	MAXLINE	 256			/* max # chars in a line */
X#define	MAXID	 12			/* max # chars in Gtab Id */
X#define	MAXLOGIN 80			/* max # chars in Gtab Login */
X
X
X/* end of tune.h */
!STUFFY!FUNK!
echo Extracting getty.h
sed >getty.h <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: getty.h,v 2.0 90/09/19 19:59:15 paul Rel $
X**
X**	Included by all getty modules
X*/
X
X/*
X**	Copyright 1989,1990 by Paul Sutcliffe Jr.
X**
X**	Permission is hereby granted to copy, reproduce, redistribute,
X**	or otherwise use this software as long as: there is no monetary
X**	profit gained specifically from the use or reproduction or this
X**	software, it is not sold, rented, traded or otherwise marketed,
X**	and this copyright notice is included prominently in any copy
X**	made.
X**
X**	The author make no claims as to the fitness or correctness of
X**	this software for any use whatsoever, and it is provided as is. 
X**	Any use of this software is at the user's own risk.
X*/
X
X/*
X**	$Log:	getty.h,v $
X**	Revision 2.0  90/09/19  19:59:15  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X#include "config.h"
X
X#include <stdio.h>
X#include <string.h>
X#include <sys/types.h>
X#include <termio.h>
X#ifdef	IOCTL
X#include <sys/ioctl.h>
X#endif	/* IOCTL */
X#ifdef	FCNTL
X#include <fcntl.h>
X#endif	/* FCNTL */
X#include <utmp.h>
X
X#include "extern.h"
X#include "funcs.h"
X
X
X/*	General purpose defines
X */
X
X#ifndef	FALSE
X#define	FALSE	(0)
X#endif	/* FALSE */
X#ifndef	TRUE
X#define	TRUE	(1)
X#endif	/* TRUE */
X
X#define OK	(0)
X
X#define SUCCESS	(0)		/* normal return */
X#define FAIL	(-1)		/* error return */
X
X#define	STDIN	fileno(stdin)
X#define	STDOUT	fileno(stdout)
X
X#define strequal(s1, s2)	(strcmp(s1, s2) == 0)
X#define strnequal(s1, s2, n)	(strncmp(s1, s2, n) == 0)
X#define	strncopy(s1, s2)	(strncpy(s1, s2, sizeof(s1)))
X
Xtypedef	struct termio	TERMIO;
X
X
X#ifdef	DEBUG
X
X/* debug levels
X */
X#define	D_OPT	0001		/* option settings */
X#define	D_DEF	0002		/* defaults file processing */
X#define	D_UTMP	0004		/* utmp/wtmp processing */
X#define	D_INIT	0010		/* line initialization (INIT) */
X#define	D_GTAB	0020		/* gettytab file processing */
X#define	D_GETL	0040		/* get login name routine */
X#define	D_RUN	0100		/* other runtime diagnostics */
X
X#ifdef	UUGETTY
X#define	D_LOCK	0200		/* uugetty lockfile processing */
X#endif	/* UUGETTY */
X
X/* debug defs
X */
X#define	debug1(a,b)		dprint(a,b)
X#define	debug2(a,b)		debug(a,b)
X#define	debug3(a,b,c)		debug(a,b,c)
X#define	debug4(a,b,c,d)		debug(a,b,c,d)
X#define	debug5(a,b,c,d,e)	debug(a,b,c,d,e)
X#define	debug6(a,b,c,d,e,f)	debug(a,b,c,d,e,f)
X
X#else	/* DEBUG */
X
X#define	debug1(a,b)		/* define to nothing, disables debugging */
X#define	debug2(a,b)
X#define	debug3(a,b,c)
X#define	debug4(a,b,c,d)
X#define	debug5(a,b,c,d,e)
X#define	debug6(a,b,c,d,e,f)
X
X#endif	/* DEBUG */
X
X
X/* end of getty.h */
!STUFFY!FUNK!
echo Extracting man/putenv.m4
sed >man/putenv.m4 <<'!STUFFY!FUNK!' -e 's/X//'
X.\" +----------
X.\" |	$Id: putenv.m4,v 2.0 90/09/19 20:14:13 paul Rel $
X.\" |
X.\" |	PUTENV man page.
X.\" |
X.\" |	Copyright 1989,1990 by Paul Sutcliffe Jr.
X.\" |
X.\" |	Permission is hereby granted to copy, reproduce, redistribute,
X.\" |	or otherwise use this software as long as: there is no monetary
X.\" |	profit gained specifically from the use or reproduction or this
X.\" |	software, it is not sold, rented, traded or otherwise marketed,
X.\" |	and this copyright notice is included prominently in any copy
X.\" |	made.
X.\" |
X.\" |	The author make no claims as to the fitness or correctness of
X.\" |	this software for any use whatsoever, and it is provided as is. 
X.\" |	Any use of this software is at the user's own risk.
X.\" |
X.\"
X.\" +----------
X.\" |	$Log:	putenv.m4,v $
X.\" |	Revision 2.0  90/09/19  20:14:13  paul
X.\" |	Initial 2.0 release
X.\" |	
X.\" |	
X.\" 
X.\" +----------
X.\" | M4 configuration
X.\"
Xinclude(config.m4).\"
X.\"
X.\" +----------
X.\" | Manpage source follows:
X.\"
X.TH PUTENV _library_section_
X.SH NAME
Xputenv \- change or add value to environment
X.SH SYNOPSIS
X.B int putenv(\fIstring\fB)\fR;
X.br
X.B char *\fIstring\fR;
X.SH DESCRIPTION
X.I String
Xpoints to a string of the form
X.I name=value.
X.I Putenv
Xmakes the value of the environment variable
X.I name
Xequal to
X.I value
Xby altering an existing variable or creating a new one.  In either
Xcase, the string pointed to by
X.I string
Xbecomes part of the environment, so altering the string changes
Xthe environment.  The space used by
X.I string
Xis no longer used once a new string\-defining
X.I name
Xis passed to
X.I putenv.
X.SH "RETURN VALUE"
X.I Putenv
Xreturns non\-zero if it was unable to obtain enough space via
X.I malloc
Xfor an expanded environment, otherwise zero.
X.SH "SEE ALSO"
Xexec(_system_section_),
Xgetenv(_library_section_),
Xmalloc(_library_section_),
Xenviron(_file_section_)
X.SH WARNINGS
X.I Putenv
Xmanipulates the environment pointed to by
X.I environ,
Xand can be used in conjunction with
X.I getenv.
XHowever,
X.I envp
X(the third argument to
X.IR main )
Xis not changed.
X.PP
XThis routine uses
X.IR malloc (_library_section_)
Xto enlarge the environment.
X.PP
XAfter
X.I putenv
Xis called, environmental variables are not in alphabetical order.
X.PP
XA potential error is to call
X.I putenv
Xwith an automatic variable as the argument, then exit the calling
Xfunction while
X.I string
Xis still part of the environment.
X.SH AUTHOR
X.nf
XPaul Sutcliffe, Jr.  <paul at devon.lns.pa.us>
XUUCP: ...!rutgers!devon!paul
!STUFFY!FUNK!
echo Extracting putenv.c
sed >putenv.c <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: putenv.c,v 2.0 90/09/19 20:16:07 paul Rel $
X**
X**	Implements putenv(3c).
X*/
X
X/*
X**	Copyright 1989,1990 by Paul Sutcliffe Jr.
X**
X**	Permission is hereby granted to copy, reproduce, redistribute,
X**	or otherwise use this software as long as: there is no monetary
X**	profit gained specifically from the use or reproduction or this
X**	software, it is not sold, rented, traded or otherwise marketed,
X**	and this copyright notice is included prominently in any copy
X**	made.
X**
X**	The author make no claims as to the fitness or correctness of
X**	this software for any use whatsoever, and it is provided as is. 
X**	Any use of this software is at the user's own risk.
X*/
X
X/*
X**	$Log:	putenv.c,v $
X**	Revision 2.0  90/09/19  20:16:07  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X#include "getty.h"
X
X#if defined(RCSID) && !defined(lint)
Xstatic char *RcsId =
X"@(#)$Id: putenv.c,v 2.0 90/09/19 20:16:07 paul Rel $";
X#endif
X
X#ifndef	MAXENV
X#define	MAXENV	64	/* max # lines in envorinment */
X#endif	/* MAXENV */
X
X
X/*
X**	putenv() - change or add value to environment
X**
X**	Returns non-zero if an error occurrs, zero otherwise.
X*/
X
Xextern char **environ;
X
Xint
Xputenv(s)
Xchar *s;
X{
X	register int i;
X	register char *p;
X	char *q, **envp, *env[MAXENV];
X	boolean match = FALSE;
X
X	if (s == (char *) NULL)
X		return(FAIL);	/* can't add NULL to the environment */
X
X	if ((p = malloc((unsigned) strlen(s)+1)) == (char *) NULL)
X		return(FAIL);	/* malloc failed */
X
X	(void) strcpy(p, s);
X	if ((q = index(p, '=')) == (char *) NULL) {
X		free(p);
X		return(FAIL);	/* not in the form ``name=value'' */
X	}
X
X	*q = '\0';		/* split into two fields, name & value */
X
X	/* copy the environ list, replacing `s' if a match is found
X	 */
X	for (i=0, envp=environ; *envp != (char *) NULL; i++, envp++) {
X		if (strnequal(*envp, p, strlen(p))) {
X			match = TRUE;
X			env[i] = s;
X		} else
X			env[i] = *envp;
X	}
X
X	if (!match) {
X		*q = '=';	/* put back the equal sign */
X		env[i++] = p;	/* add p to env list */
X	} else
X		free(p);	/* not needed, s replaced old value */
X
X	env[i++] = (char *) NULL;
X
X	/* now dup env to make new environment
X	 */
X	if ((envp = (char **) malloc((unsigned) (i*sizeof(char *)))) ==
X	    (char **) NULL) {
X		return(FAIL);
X	}
X	environ = envp;		/* point to new area */
X	for (i=0; env[i] != (char *) NULL; i++)
X		*envp++ = env[i];
X	*envp = (char *) NULL;
X
X	return(SUCCESS);
X}
X
X
X/* end of putenv.c */
!STUFFY!FUNK!
echo Extracting sample.files
sed >sample.files <<'!STUFFY!FUNK!' -e 's/X//'
XThese examples are from the author's system.
X
XSample `/etc/issue' file:
X+---------
X| Devon Computer Services, Lancaster, PA  (@S)
X| Tandy XENIX/68000 Version @V
X+---------
X
XSample `/etc/default/uugetty' file:
X+---------
X| ISSUE=[@D, @T]\nDevon Computer Services - Tandy 6000  (@S)\n
X| INIT="" A\pA\pA\pAT\r OK\r\n-ATZ\r-OK\r\n ATZ\r OK\r\n
X| TIMEOUT=60
X| #
X| # set S0=0 (no answer); wait for RING, then go to answer mode and
X| # look for the right speed
X| #
X| WAITFOR=RING
X| CONNECT="" ATA\r CONNECT\s\A
X+---------
X
XSample `/etc/gettydefs' file:
X+---------
X| #
X| # Sample /etc/gettydefs file; use at your own risk!
X| #
X| # default entry:
X| 0# B9600 CS8 # B9600 CLOCAL TAB3 ECHO SANE #login: #0
X| 
X| # to toggle between 300 and 1200 baud on a modem line:
X| #
X| 1# B300 ISTRIP CS8 CR1 # B300 HUPCL CS8 TAB3 SANE CR1 #login: #2
X| 
X| 2# B1200 ISTRIP CS8 # B1200 HUPCL CS8 TAB3 SANE #login: #1
X| 
X| # to toggle between 300, 1200 and 2400 baud on a modem line:
X| #
X| 3# B300 ISTRIP CS8 CR1 # B300 HUPCL CS8 TAB3 SANE CR1 #login: #4
X| 
X| 4# B1200 ISTRIP CS8 # B1200 HUPCL CS8 TAB3 SANE #login: #5
X| 
X| 5# B2400 ISTRIP CS8 # B2400 HUPCL CS8 TAB3 SANE #login: #3
X| 
X| # a telebit tb plus:
X| #
X| 6# B9600 ISTRIP CS8 # B9600 HUPCL CS8 TAB3 SANE #FAST login: #7
X| 
X| 7# B2400 ISTRIP CS8 # B2400 HUPCL CS8 TAB3 SANE #login: #8
X| 
X| 8# B1200 ISTRIP CS8 # B1200 HUPCL CS8 TAB3 SANE #login: #6
X| 
X| # various hard-wired speeds
X| a# B50 ISTRIP CS8 NL1 CR3 TAB2 # B50 CS8 CLOCAL SANE NL1 CR3 TAB2 #login: #a
X| 
X| b# B75 ISTRIP CS8 NL1 CR2 TAB2 # B75 CS8 CLOCAL SANE NL1 CR2 TAB2 #login: #b
X| 
X| c# B110 ISTRIP CS8 NL1 CR1 TAB1 # B110 CS8 CLOCAL SANE NL1 CR1 TAB1 #login: #c
X| 
X| d# B134 ISTRIP CS8 NL1 CR1 TAB1 # B134 CS8 CLOCAL SANE NL1 CR1 TAB1 #login: #d
X| 
X| e# B150 ISTRIP CS8 NL1 CR1 # B150 CS8 CLOCAL TAB3 SANE NL1 CR1 #login: #e
X| 
X| f# B200 ISTRIP CS8 NL1 CR1 # B200 CS8 CLOCAL TAB3 SANE NL1 CR1 #login: #f
X| 
X| g# B300 ISTRIP CS8 CR1 # B300 CS8 CLOCAL TAB3 SANE CR1 #login: #g
X| 
X| h# B600 ISTRIP CS8 # B600 CS8 CLOCAL TAB3 SANE #login: #h
X| 
X| i# B1200 ISTRIP CS8 # B1200 CS8 CLOCAL TAB3 SANE #login: #i
X| 
X| j# B1800 ISTRIP CS8 # B1800 CS8 CLOCAL TAB3 SANE #login: #j
X| 
X| k# B2400 ISTRIP CS8 # B2400 CS8 CLOCAL TAB3 SANE #login: #k
X| 
X| l# B4800 ISTRIP CS8 # B4800 CS8 CLOCAL TAB3 SANE #login: #l
X| 
X| m# B9600 ISTRIP CS8 # B9600 CS8 CLOCAL TAB3 SANE #login: #m
X| 
X+---------
!STUFFY!FUNK!
echo Extracting getutent.c
sed >getutent.c <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: getutent.c,v 2.0 90/09/19 20:00:51 paul Rel $
X**
X**	Implements getutent(3).
X*/
X
X/*
X**	Copyright 1989,1990 by Paul Sutcliffe Jr.
X**
X**	Permission is hereby granted to copy, reproduce, redistribute,
X**	or otherwise use this software as long as: there is no monetary
X**	profit gained specifically from the use or reproduction or this
X**	software, it is not sold, rented, traded or otherwise marketed,
X**	and this copyright notice is included prominently in any copy
X**	made.
X**
X**	The author make no claims as to the fitness or correctness of
X**	this software for any use whatsoever, and it is provided as is. 
X**	Any use of this software is at the user's own risk.
X*/
X
X/*
X**	$Log:	getutent.c,v $
X**	Revision 2.0  90/09/19  20:00:51  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X#include "getty.h"
X
X#if defined(RCSID) && !defined(lint)
Xstatic char *RcsId =
X"@(#)$Id: getutent.c,v 2.0 90/09/19 20:00:51 paul Rel $";
X#endif
X
Xtypedef	struct utmp	UTMP;
X
Xstatic	char	*utmpfil = UTMP_FILE;	/* default utmp file */
Xstatic	FILE	*ufp = (FILE *) NULL;	/* file pointer to utmp file */
X					/* NULL = no utmp file open  */
Xstatic	UTMP	ut;			/* buffer for utmp record */
X
X
X/*
X**	getutent() - get next valid utmp entry
X**
X**	Returns (UTMP*)NULL if no vaild entry found.
X*/
X
XUTMP *
Xgetutent()
X{
X	if (ufp == (FILE *) NULL)
X		if ((ufp = fopen(utmpfil, "r+")) == (FILE *) NULL)
X			return((UTMP *) NULL);
X
X	do {
X		if (fread((char *)&ut, sizeof(ut), 1, ufp) != 1)
X			return((UTMP *) NULL);
X
X	} while (ut.ut_name[0] == '\0');	/* valid entry? */
X
X	return(&ut);
X}
X
X
X/*
X**	getutline() - get utmp entry that matches line.
X**
X**	Returns (UTMP*)NULL if no match found.
X*/
X
XUTMP *
Xgetutline(line)
Xregister UTMP *line;
X{
X	do {
X		if (strequal(ut.ut_line, line->ut_line))
X			return(&ut);	/* match! */
X
X	} while (getutent() != NULL);
X
X	return((UTMP *) NULL);
X}
X
X
X/*
X**	setutent() - rewind utmp back to beginning
X*/
X
Xvoid
Xsetutent()
X{
X	if (ufp != (FILE *) NULL)
X		rewind(ufp);
X}
X	
X
X/*
X**	endutent() - close utmp file
X*/
X
Xvoid
Xendutent()
X{
X	if (ufp != (FILE *) NULL) {
X		(void) fclose(ufp);
X		ufp = (FILE *) NULL;
X	}
X}
X
X
X/*
X**	utmpname() - change utmp file name to "file"
X*/
X
Xvoid
Xutmpname(file)
Xregister char *file;
X{
X	endutent();
X	utmpfil = strdup(file);
X}
X
X
X/* end of getutent.c */
!STUFFY!FUNK!
echo Extracting man/Makefile.SH
sed >man/Makefile.SH <<'!STUFFY!FUNK!' -e 's/X//'
X:
X# $Id: Makefile.SH,v 2.0 90/09/19 20:07:16 paul Rel $
X#
X# Creates man/Makefile for getty distribution
X#
X# $Log:	Makefile.SH,v $
X# Revision 2.0  90/09/19  20:07:16  paul
X# Initial 2.0 release
X# 
X# 
X
Xcase $CONFIG in
X'')
X    if test ! -f config.sh; then
X	ln ../config.sh . || \
X	ln ../../config.sh . || \
X	ln ../../../config.sh . || \
X	(echo "Can't find config.sh."; exit 1)
X    fi
X    . config.sh
X    ;;
Xesac
Xcase "$0" in
X*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
Xesac
X
Xgtab=`basename $gettytab`
Xall="getty.1m $gtab.4 issue.4"
Xman="getty.man $gtab.man issue.man"
Xcase "$d_getutent" in
X"$undef")
X    all="$all getutent.3"
X    man="$man getutent.man"
X    ;;
Xesac
Xcase "$d_strdup" in
X"$undef")
X    all="$all strdup.3"
X    man="$man strdup.man"
X    ;;
Xesac
Xcase "$d_putenv" in
X"$undef")
X    all="$all putenv.3"
X    man="$man putenv.man"
X    ;;
Xesac
X
Xecho "Extracting man/Makefile (with variable substitutions)"
X$spitshell >Makefile <<!GROK!THIS!
X#
X# Makefile for getty man pages
X#
X
XSHELL=	/bin/sh
X# no nroff?  get Henry Spencer's AWF!
XROFF=	nroff -man
X
XSRC=	..
XTUNE=	$(SRC)/tune.h
XRELEASE=$(SRC)/release.h
X
X# what to make
Xall:	$all
X
Xman:	$man
X
Xinstall:
X	@echo "Manpage installation must be done manually, Sorry."
X
X# how to make it
X.SUFFIXES: .m4 .3 .man
X
X.m4.3:
X	m4 \$*.m4 > \$*.3
X
X.3.man:
X	$(ROFF) \$*.3 > \$*.man
X
X# dependencies
Xconfig.m4:	$(SRC)/config.sh $(TUNE) $(RELEASE)
X	chmod +x makeconfig
X	./makeconfig
X
Xgetty.1m:	getty.m4 config.m4
X	m4 getty.m4 > getty.1m
X
Xgetty.man:	getty.1m
X	$(ROFF) getty.1m > getty.man
X
X$gtab.4:	gettytab.m4 config.m4
X	m4 gettytab.m4 > $gtab.4
X
X$gtab.man:	$gtab.4
X	$(ROFF) $gtab.4 > $gtab.man
X
Xissue.4:	issue.m4 config.m4
X	m4 issue.m4 > issue.4
X
Xissue.man:	issue.4
X	$(ROFF) issue.4 > issue.man
X
Xgetutent.3:	getutent.m4 config.m4
X
Xgetutent.man:	getutent.3
X
Xstrdup.3:	strdup.m4 config.m4
X
Xstrdup.man:	strdup.3
X
Xputenv.3:	putenv.m4 config.m4
X
Xputenv.man:	putenv.3
X
Xclean:
X	rm -f *.out config.m4 config.sh core
X
Xclobber: clean
X	rm -f *.1m *.[34] *.man
X
X!GROK!THIS!
Xchmod 644 Makefile
X$eunicefix Makefile
!STUFFY!FUNK!
echo Extracting MANIFEST
sed >MANIFEST <<'!STUFFY!FUNK!' -e 's/X//'
XAfter all the getty kits are run you should have the following files:
X
XFilename		Kit Description
X--------		--- -----------
XConfigure                2 Determines system configuration.
XMANIFEST                 4 Packing list.
XMakefile.SH              4 Creates Makefile file.
XREADME                   1 The Instructions.
Xconfig.h.SH              4 Creates config.h file.
Xdefaults.c               3 Routines to access the runtime defaults file.
Xdefaults.h               5 Defines the defaults file structures.
Xextern.h                 3 Defines all external values.
Xfuncs.c                  3 Miscellaneous routines.
Xfuncs.h                  5 Definitions for miscellaneous routines.
Xgetty.h                  4 Common header for all modules.
Xgetutent.c               4 Implements getutent(3).
Xmain.c                   1 Main body of program.
Xmakedep.SH               4 Creates makedep file.
Xman/Makefile.SH          4 Creates man/Makefile file.
Xman/README               1 Notes about the manual pages.
Xman/getty.m4             3 M4 source to getty manpage.
Xman/gettytab.m4          4 M4 source to gettytab manpage.
Xman/getutent.m4          4 M4 source to getutent manpage.
Xman/issue.m4             4 M4 source to issue manpage.
Xman/makeconfig           4 Creates config.m4 file.
Xman/putenv.m4            4 M4 source to putenv manpage.
Xman/strdup.m4            4 M4 source to strdup manpage.
Xpatchlevel.h             3 Getty patchlevel.
Xputenv.c                 4 Implements putenv(3c).
Xrelease.h                1 Getty release/date.
Xsample.files             4 Sample ancillary files.
Xstrdup.c                 5 Implements strdup(3c).
Xtable.c                  1 Routines to process the gettytab file.
Xtable.h                  4 Defines the gettytab structures.
Xtune.H                   4 Sample tune.h file.
!STUFFY!FUNK!
echo Extracting man/strdup.m4
sed >man/strdup.m4 <<'!STUFFY!FUNK!' -e 's/X//'
X.\" +----------
X.\" |	$Id: strdup.m4,v 2.0 90/09/19 20:14:57 paul Rel $
X.\" |
X.\" |	STRDUP man page.
X.\" |
X.\" |	Copyright 1989,1990 by Paul Sutcliffe Jr.
X.\" |
X.\" |	Permission is hereby granted to copy, reproduce, redistribute,
X.\" |	or otherwise use this software as long as: there is no monetary
X.\" |	profit gained specifically from the use or reproduction or this
X.\" |	software, it is not sold, rented, traded or otherwise marketed,
X.\" |	and this copyright notice is included prominently in any copy
X.\" |	made.
X.\" |
X.\" |	The author make no claims as to the fitness or correctness of
X.\" |	this software for any use whatsoever, and it is provided as is. 
X.\" |	Any use of this software is at the user's own risk.
X.\" |
X.\"
X.\" +----------
X.\" |	$Log:	strdup.m4,v $
X.\" |	Revision 2.0  90/09/19  20:14:57  paul
X.\" |	Initial 2.0 release
X.\" |	
X.\" |	
X.\" 
X.\" +----------
X.\" | M4 configuration
X.\"
Xinclude(config.m4).\"
X.\"
X.\" +----------
X.\" | Manpage source follows:
X.\"
X.TH STRDUP _library_section_
X.SH NAME
Xstrdup \- duplicate a string in memory
X.SH SYNOPSIS
X.B char *strdup(\fIstring\fB)\fR;
X.br
X.B char *\fIstring\fR;
X.SH DESCRIPTION
X.I Strdup
Xallocates storage space (with a call to
X.IR malloc (_library_section_))
Xfor a copy of
X.I string
Xand returns a pointer to the storage space containing the copied
Xstring.
X.SH "RETURN VALUE"
X.I Strdup
Xreturns NULL if storage cannot be allocated.  Otherwise, a valid
Xpointer is returned.
X.SH "SEE ALSO"
Xmalloc(_library_section_),
Xstring(_library_section_)
X.SH AUTHOR
X.nf
XPaul Sutcliffe, Jr.  <paul at devon.lns.pa.us>
XUUCP: ...!rutgers!devon!paul
!STUFFY!FUNK!
echo Extracting table.h
sed >table.h <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: table.h,v 2.0 90/09/19 20:19:21 paul Rel $
X**
X**	Defines the structures and functions used to parse the
X**	gettytab file.
X*/
X
X/*
X**	Copyright 1989,1990 by Paul Sutcliffe Jr.
X**
X**	Permission is hereby granted to copy, reproduce, redistribute,
X**	or otherwise use this software as long as: there is no monetary
X**	profit gained specifically from the use or reproduction or this
X**	software, it is not sold, rented, traded or otherwise marketed,
X**	and this copyright notice is included prominently in any copy
X**	made.
X**
X**	The author make no claims as to the fitness or correctness of
X**	this software for any use whatsoever, and it is provided as is. 
X**	Any use of this software is at the user's own risk.
X*/
X
X/*
X**	$Log:	table.h,v $
X**	Revision 2.0  90/09/19  20:19:21  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X#ifndef	LDISC0
X#define	LDISC0	0			/* default line discipline */
X#endif	/* LDISC0 */
X
X#ifndef	GETTYTAB
X#define	GETTYTAB  "/etc/gettydefs"	/* default name of the gettytab file */
X#endif	/* GETTYTAB */
X
X/* 	Modes for gtabvalue()
X */
X#define	G_CHECK	0			/* nothing */
X#define	G_FIND	1			/* find requested entry only */
X#define	G_FORCE	2			/* make alternate choices */
X
Xtypedef	struct Gettytab {
X	char	*cur_id;		/* current label */
X	TERMIO	itermio;		/* initial termio flags */
X	TERMIO	ftermio;		/* final termio flags */
X	char	*login;			/* login prompt */
X	char	*next_id;		/* next label */
X} GTAB;
X
Xtypedef	struct SymTab {
X	char	*symbol;		/* symbolic name */
X	ushort	value;			/* actual value */
X} SYMTAB;
X
XGTAB	*gtabvalue();
X
X
X/* end of table.h */
!STUFFY!FUNK!
echo Extracting man/issue.m4
sed >man/issue.m4 <<'!STUFFY!FUNK!' -e 's/X//'
X.\" +----------
X.\" |	$Id: issue.m4,v 2.0 90/09/19 20:13:21 paul Rel $
X.\" |
X.\" |	ISSUE man page.
X.\" |
X.\" |	Copyright 1989,1990 by Paul Sutcliffe Jr.
X.\" |
X.\" |	Permission is hereby granted to copy, reproduce, redistribute,
X.\" |	or otherwise use this software as long as: there is no monetary
X.\" |	profit gained specifically from the use or reproduction or this
X.\" |	software, it is not sold, rented, traded or otherwise marketed,
X.\" |	and this copyright notice is included prominently in any copy
X.\" |	made.
X.\" |
X.\" |	The author make no claims as to the fitness or correctness of
X.\" |	this software for any use whatsoever, and it is provided as is. 
X.\" |	Any use of this software is at the user's own risk.
X.\" |
X.\"
X.\" +----------
X.\" |	$Log:	issue.m4,v $
X.\" |	Revision 2.0  90/09/19  20:13:21  paul
X.\" |	Initial 2.0 release
X.\" |	
X.\" |	
X.\" 
X.\" +----------
X.\" | M4 configuration
X.\"
Xinclude(config.m4).\"
X.\"
X.\" +----------
X.\" | Manpage source follows:
X.\"
X.TH ISSUE _file_section_
X.SH NAME
Xissue \- issue identification file
X.SH DESCRIPTION
XThe file
X.B _issue_
Xcontains the
X.I issue
Xor project identification to be printed as a login prompt.  This
Xis an ASCII file which is read by the program
X.IR getty (_mcmd_section_)
Xand then written to the terminal just prior to printing the
X.I login:
Xprompt.
X.PP
XThe line(s) may contain various
X.BI @ char
Xand
X\fB\\\fIchar\fR
Xparameters.  These are described in full in the
X.IR getty (_mcmd_section_)
Xsection PROMPT SUBSTITUTIONS.
X.SH FILES
X_issue_
X.SH "SEE ALSO"
Xgetty(_mcmd_section_)
!STUFFY!FUNK!
echo ""
echo "End of kit 4 (of 5)"
cat /dev/null >kit4isdone
run=''
config=''
for iskit in 1 2 3 4 5; do
    if test -f kit${iskit}isdone; then
	run="$run $iskit"
    else
	todo="$todo $iskit"
    fi
done
case $todo in
    '')
	echo "You have run all your kits.  Please read README and then type Configure."
	chmod 755 Configure
	;;
    *)  echo "You have run$run."
	echo "You still need to run$todo."
	;;
esac
: Someone might mail this, so...
exit
