#! /bin/sh

# Make a new directory for the getty sources, cd to it, and run kits 1
# thru 5 through sh.  When all 5 kits have been run, read README.

echo "This is getty 2.0 kit 2 (of 5).  If kit 2 is complete, the line"
echo '"'"End of kit 2 (of 5)"'" will echo at the end.'
echo ""
export PATH || (echo "You didn't use sh, you clunch." ; kill $$)
mkdir  2>/dev/null
echo Extracting Configure
sed >Configure <<'!STUFFY!FUNK!' -e 's/X//'
X#! /bin/sh
X#
X# If these # comments don't work, trim them.  Don't worry about any other
X# shell scripts, Configure will trim # comments from them for you.
X#
X# (If you are trying to port this package to a machine without sh, I would
X# suggest you cut out the prototypical config.h from the end of Configure
X# and edit it to reflect your system.  Some packages may include samples
X# of config.h for certain machines, so you might look for one of those.)
X#
X# $Id: Configure,v 2.0 90/09/19 19:23:44 paul Rel $
X#
X# Yes, you may rip this off to use in other distribution packages.
X# (Note: this Configure script was generated automatically.  Rather than
X# working with this copy of Configure, you may wish to get metaconfig.)
X#
X# $Log:	Configure,v $
X# Revision 2.0  90/09/19  19:23:44  paul
X# Initial 2.0 release
X# 
X#
X
X: sanity checks
XPATH=".:/bin:/usr/bin:/usr/local/bin:/usr/ucb:/usr/local:/usr/lbin:/etc:/usr/new:/usr/new/bin:/usr/nbin:$PATH"
Xexport PATH || (echo "OOPS, this isn't sh.  Desperation time.  I will feed myself to sh."; sh $0; kill $$)
X
Xif test ! -t 0; then
X    echo "Say 'sh Configure', not 'sh <Configure'"
X    exit 1
Xfi
X
X(alias) >/dev/null 2>&1 && \
X    echo "(I see you are using the Korn shell.  Some ksh's blow up on Configure," && \
X    echo "especially on exotic machines.  If yours does, try the Bourne shell instead.)"
X
Xif test ! -d ../UU; then
X    if test ! -d UU; then
X	mkdir UU
X    fi
X    cd UU
Xfi
X
Xcase "$1" in
X-d) shift; fastread='yes';;
Xesac
X
Xd_getutent=''
Xd_strdup=''
Xd_putenv=''
Xd_ttytype=''
Xttytype=''
Xgettytab=''
Xutmp=''
Xwtmp=''
Xuucpid=''
Xlock=''
Xd_asciipid=''
Xmailer=''
Xhostname=''
Xphostname=''
Xd_douname=''
Xd_phostname=''
Xd_portable=''
Xtermlib=''
Xllib_termlib=''
Xxenix=''
Xd_eunice=''
Xdefine=''
Xundef=''
Xeunicefix=''
Xloclist=''
Xexpr=''
Xsed=''
Xecho=''
Xcat=''
Xrm=''
Xmv=''
Xcp=''
Xtr=''
Xsort=''
Xuniq=''
Xgrep=''
Xtrylist=''
Xtest=''
Xegrep=''
XMcc=''
Xcpp=''
Xmail=''
Xmailx=''
Xsendmail=''
Xuname=''
Xuuname=''
XLog=''
XId=''
Xbin=''
Xcontains=''
Xcppstdin=''
Xcppminus=''
Xd_fcntl=''
Xd_index=''
Xd_ioctl=''
Xd_varargs=''
Xd_voidsig=''
Xgidtype=''
Xi_fcntl=''
Xi_pwd=''
Xi_sysioctl=''
Xi_time=''
Xi_systime=''
Xd_systimekernel=''
Xi_varargs=''
Xlibc=''
Xmodels=''
Xsplit=''
Xsmall=''
Xmedium=''
Xlarge=''
Xhuge=''
Xoptimize=''
Xccflags=''
Xcppflags=''
Xldflags=''
Xcc=''
Xlibs=''
Xn=''
Xc=''
Xpackage=''
Xspitshell=''
Xshsharp=''
Xsharpbang=''
Xstartsh=''
Xstdchar=''
Xuidtype=''
Xvoidflags=''
Xdefvoidused=''
Xlib=''
XCONFIG=''
X: set package name
Xpackage=getty
X
Xecho " "
Xecho "Beginning of configuration questions for $package kit."
X: Eunice requires " " instead of "", can you believe it
Xecho " "
X
Xdefine='define'
Xundef='undef'
X: change the next line if compiling for Xenix/286 on Xenix/386
Xxlibpth='/usr/lib/386 /lib/386'
Xlibpth='/usr/lib /usr/local/lib /usr/lib/large /lib '$xlibpth' /lib/large /usr/lib/small /lib/small'
Xsmallmach='pdp11 i8086 z8000 i80286 iAPX286'
Xrmlist='kit[1-9]isdone kit[1-9][0-9]isdone'
Xtrap 'echo " "; rm -f $rmlist; exit 1' 1 2 3
X
X: We must find out about Eunice early
Xeunicefix=':'
Xif test -f /etc/unixtovms; then
X    eunicefix=/etc/unixtovms
Xfi
Xif test -f /etc/unixtovms.exe; then
X    eunicefix=/etc/unixtovms.exe
Xfi
X
X: Now test for existence of everything in MANIFEST
X
Xecho "First let's make sure your kit is complete.  Checking..."
X(cd ..; cat `awk 'NR>4{print $1}' MANIFEST` >/dev/null || kill $$)
Xecho "Looks good..."
X
Xattrlist="mc68000 sun gcos unix ibm gimpel interdata tss os mert pyr"
Xattrlist="$attrlist vax pdp11 i8086 z8000 u3b2 u3b5 u3b20 u3b200"
Xattrlist="$attrlist hpux hp9000s300 hp9000s500 hp9000s800"
Xattrlist="$attrlist ns32000 ns16000 iAPX286 mc300 mc500 mc700 sparc"
Xattrlist="$attrlist nsc32000 sinix xenix venix posix ansi M_XENIX"
Xattrlist="$attrlist $mc68k __STDC__ UTS M_I8086 M_I186 M_I286 M_I386"
Xattrlist="$attrlist i186 __m88k__ m88k DGUX __DGUX__"
Xpth="/usr/ucb /bin /usr/bin /usr/local /usr/local/bin /usr/lbin /usr/plx /usr/5bin /vol/local/bin /etc /usr/lib /lib /usr/local/lib /sys5.3/bin /sys5.3/usr/bin /bsd4.3/bin /bsd4.3/usr/bin /bsd4.3/usr/ucb"
Xdefvoidused=7
Xlibswanted="x c_s"
Xinclwanted=''
X
X: some greps do not return status, grrr.
Xecho "grimblepritz" >grimble
Xif grep blurfldyick grimble >/dev/null 2>&1 ; then
X    contains=contains
Xelif grep grimblepritz grimble >/dev/null 2>&1 ; then
X    contains=grep
Xelse
X    contains=contains
Xfi
Xrm -f grimble
X: the following should work in any shell
Xcase "$contains" in
Xcontains*)
X    echo " "
X    echo "AGH!  Grep doesn't return a status.  Attempting remedial action."
X    cat >contains <<'EOSS'
Xgrep "$1" "$2" >.greptmp && cat .greptmp && test -s .greptmp
XEOSS
Xchmod +x contains
Xesac
X
X: see if sh knows # comments
Xecho " "
Xecho "Checking your sh to see if it knows about # comments..."
Xif sh -c '#' >/dev/null 2>&1 ; then
X    echo "Your sh handles # comments correctly."
X    shsharp=true
X    spitshell=cat
X    echo " "
X    echo "Okay, let's see if #! works on this system..."
X    echo "#!/bin/echo hi" > try
X    $eunicefix try
X    chmod +x try
X    ./try > today
X    if $contains hi today >/dev/null 2>&1; then
X	echo "It does."
X	sharpbang='#!'
X    else
X	echo "#! /bin/echo hi" > try
X	$eunicefix try
X	chmod +x try
X	./try > today
X	if test -s today; then
X	    echo "It does."
X	    sharpbang='#! '
X	else
X	    echo "It doesn't."
X	    sharpbang=': use '
X	fi
X    fi
Xelse
X    echo "Your sh doesn't grok # comments--I will strip them later on."
X    shsharp=false
X    echo "exec grep -v '^#'" >spitshell
X    chmod +x spitshell
X    $eunicefix spitshell
X    spitshell=`pwd`/spitshell
X    echo "I presume that if # doesn't work, #! won't work either!"
X    sharpbang=': use '
Xfi
X
X: figure out how to guarantee sh startup
Xecho " "
Xecho "Checking out how to guarantee sh startup..."
Xstartsh=$sharpbang'/bin/sh'
Xecho "Let's see if '$startsh' works..."
Xcat >try <<EOSS
X$startsh
Xset abc
Xtest "$?abc" != 1
XEOSS
X
Xchmod +x try
X$eunicefix try
Xif ./try; then
X    echo "Yup, it does."
Xelse
X    echo "Nope.  You may have to fix up the shell scripts to make sure sh runs them."
Xfi
Xrm -f try today
X
X: first determine how to suppress newline on echo command
Xecho "Checking echo to see how to suppress newlines..."
X(echo "hi there\c" ; echo " ") >.echotmp
Xif $contains c .echotmp >/dev/null 2>&1 ; then
X    echo "...using -n."
X    n='-n'
X    c=''
Xelse
X    cat <<'EOM'
X...using \c
XEOM
X    n=''
X    c='\c'
Xfi
Xecho $n "Type carriage return to continue.  Your cursor should be here-->$c"
Xread ans
Xrm -f .echotmp
X
X: now set up to do reads with possible shell escape and default assignment
Xcat <<EOSC >myread
Xcase "\$fastread" in
Xyes) ans=''; echo " " ;;
X*) ans='!';;
Xesac
Xwhile expr "X\$ans" : "X!" >/dev/null; do
X    read ans
X    case "\$ans" in
X    !)
X	sh
X	echo " "
X	echo $n "\$rp $c"
X	;;
X    !*)
X	set \`expr "X\$ans" : "X!\(.*\)\$"\`
X	sh -c "\$*"
X	echo " "
X	echo $n "\$rp $c"
X	;;
X    esac
Xdone
Xrp='Your answer:'
Xcase "\$ans" in
X'') ans="\$dflt";;
Xesac
XEOSC
X
X: general instructions
Xcat <<EOH
X 
XThis installation shell script will examine your system and ask you questions
Xto determine how the $package package should be installed.  If you get stuck
Xon a question, you may use a ! shell escape to start a subshell or execute
Xa command.  Many of the questions will have default answers in square
Xbrackets--typing carriage return will give you the default.
X
XOn some of the questions which ask for file or directory names you are
Xallowed to use the ~name construct to specify the login directory belonging
Xto "name", even if you don't have a shell which knows about that.  Questions
Xwhere this is allowed will be marked "(~name ok)".
X
XEOH
Xrp="[Type carriage return to continue]"
Xecho $n "$rp $c"
X. myread
Xcat <<EOH
X
XMuch effort has been expended to ensure that this shell script will run
Xon any Unix system.  If despite that it blows up on you, your best bet is
Xto edit Configure and run it again. Also, let me (paul at devon.lns.pa.us)
Xknow how I blew it.  If you can't run Configure for some reason, you'll have
Xto generate a config.sh file by hand.
X
XThis installation script affects things in two ways: 1) it may do direct
Xvariable substitutions on some of the files included in this kit, and
X2) it builds a config.h file for inclusion in C programs.  You may edit
Xany of these files as the need arises after running this script.
X
XIf you make a mistake on a question, there is no easy way to back up to it
Xcurrently.  The easiest thing to do is to edit config.sh and rerun all the
XSH files.  Configure will offer to let you do this before it runs the SH files.
X
XEOH
Xrp="[Type carriage return to continue]"
Xecho $n "$rp $c"
X. myread
X
X: get old answers, if there is a config file out there
Xif test -f ../config.sh; then
X    echo " "
X    dflt=y
X    rp="I see a config.sh file.  Did Configure make it on THIS system? [$dflt]"
X    echo $n "$rp $c"
X    . myread
X    case "$ans" in
X    n*) echo "OK, I'll ignore it.";;
X    *)  echo "Fetching default answers from your old config.sh file..."
X	tmp="$n"
X	ans="$c"
X        . ../config.sh
X	n="$tmp"
X	c="$ans"
X	;;
X    esac
Xfi
X
X: find out where common programs are
Xecho " "
Xecho "Locating common programs..."
Xcat <<EOSC >loc
X$startsh
Xcase \$# in
X0) exit 1;;
Xesac
Xthing=\$1
Xshift
Xdflt=\$1
Xshift
Xfor dir in \$*; do
X    case "\$thing" in
X    .)
X	if test -d \$dir/\$thing; then
X	    echo \$dir
X	    exit 0
X	fi
X	;;
X    *)
X	if test -f \$dir/\$thing; then
X	    echo \$dir/\$thing
X	    exit 0
X	elif test -f \$dir/\$thing.exe; then
X	    : on Eunice apparently
X	    echo \$dir/\$thing
X	    exit 0
X	fi
X	;;
X    esac
Xdone
Xecho \$dflt
Xexit 1
XEOSC
Xchmod +x loc
X$eunicefix loc
Xloclist="
Xcat
Xcp
Xecho
Xexpr
Xgrep
Xmv
Xrm
Xsed
Xsort
Xtr
Xuniq
X"
Xtrylist="
XMcc
Xcpp
Xegrep
Xmail
Xmailx
Xsendmail
Xtest
X"
Xfor file in $loclist; do
X    xxx=`loc $file $file $pth`
X    eval $file=$xxx
X    eval _$file=$xxx
X    case "$xxx" in
X    /*)
X	echo $file is in $xxx.
X	;;
X    *)
X	echo "I don't know where $file is.  I hope it's in everyone's PATH."
X	;;
X    esac
Xdone
Xecho " "
Xecho "Don't worry if any of the following aren't found..."
Xans=offhand
Xfor file in $trylist; do
X    xxx=`loc $file $file $pth`
X    eval $file=$xxx
X    eval _$file=$xxx
X    case "$xxx" in
X    /*)
X	echo $file is in $xxx.
X	;;
X    *)
X	echo "I don't see $file out there, $ans."
X	ans=either
X	;;
X    esac
Xdone
Xcase "$egrep" in
Xegrep)
X    echo "Substituting grep for egrep."
X    egrep=$grep
X    ;;
Xesac
Xcase "$test" in
Xtest)
X    echo "Hopefully test is built into your sh."
X    ;;
X/bin/test)
X    if sh -c "PATH= test true" >/dev/null 2>&1; then
X	echo "Using the test built into your sh."
X	test=test
X    fi
X    ;;
X*)
X    test=test
X    ;;
Xesac
Xcase "$echo" in
Xecho)
X    echo "Hopefully echo is built into your sh."
X    ;;
X/bin/echo)
X    echo " "
X    echo "Checking compatibility between /bin/echo and builtin echo (if any)..."
X    $echo $n "hi there$c" >foo1
X    echo $n "hi there$c" >foo2
X    if cmp foo1 foo2 >/dev/null 2>&1; then
X	echo "They are compatible.  In fact, they may be identical."
X    else
X	case "$n" in
X	'-n') n='' c='\c' ans='\c' ;;
X	*) n='-n' c='' ans='-n' ;;
X	esac
X	cat <<FOO
XThey are not compatible!  You are probably running ksh on a non-USG system.
XI'll have to use /bin/echo instead of the builtin, since Bourne shell doesn't
Xhave echo built in and we may have to run some Bourne shell scripts.  That
Xmeans I'll have to use $ans to suppress newlines now.  Life is ridiculous.
X
XFOO
X	rp="Your cursor should be here-->"
X	$echo $n "$rp$c"
X	. myread
X    fi
X    $rm -f foo1 foo2
X    ;;
X*)
X    : cross your fingers
X    echo=echo
X    ;;
Xesac
Xrmlist="$rmlist loc"
X
X: set up shell script to do ~ expansion
Xcat >filexp <<EOSS
X$startsh
X: expand filename
Xcase "\$1" in
X ~/*|~)
X    echo \$1 | $sed "s|~|\${HOME-\$LOGDIR}|"
X    ;;
X ~*)
X    if $test -f /bin/csh; then
X	/bin/csh -f -c "glob \$1"
X	echo ""
X    else
X	name=\`$expr x\$1 : '..\([^/]*\)'\`
X	dir=\`$sed -n -e "/^\${name}:/{s/^[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:\([^:]*\).*"'\$'"/\1/" -e p -e q -e '}' </etc/passwd\`
X	if $test ! -d "\$dir"; then
X	    me=\`basename \$0\`
X	    echo "\$me: can't locate home directory for: \$name" >&2
X	    exit 1
X	fi
X	case "\$1" in
X	*/*)
X	    echo \$dir/\`$expr x\$1 : '..[^/]*/\(.*\)'\`
X	    ;;
X	*)
X	    echo \$dir
X	    ;;
X	esac
X    fi
X    ;;
X*)
X    echo \$1
X    ;;
Xesac
XEOSS
Xchmod +x filexp
X$eunicefix filexp
X
X: determine where public executables go
Xcase "$bin" in
X'')
X    dflt=`loc . /etc /bin /usr/local/bin /usr/lbin /usr/local /usr/bin`
X    ;;
X*)  dflt="$bin"
X    ;;
Xesac
Xcont=true
Xwhile $test "$cont" ; do
X    echo " "
X    rp="Where do you want to put the public executables? (~name ok) [$dflt]"
X    $echo $n "$rp $c"
X    . myread
X    bin="$ans"
X    bin=`./filexp "$bin"`
X    if test -d $bin; then
X	cont=''
X    else
X	case "$fastread" in
X	yes) dflt=y;;
X	*) dflt=n;;
X	esac
X	rp="Directory $bin doesn't exist.  Use that name anyway? [$dflt]"
X	$echo $n "$rp $c"
X	. myread
X	dflt=''
X	case "$ans" in
X	y*) cont='';;
X	esac
X    fi
Xdone
X
X: make some quick guesses about what we are up against
Xecho " "
X$echo $n "Hmm...  $c"
Xcat /usr/include/signal.h /usr/include/sys/signal.h >foo
Xif test `echo abc | tr a-z A-Z` = Abc ; then
X    echo "Looks kind of like a USG system, but we'll see..."
X    echo exit 1 >bsd
X    echo exit 0 >usg
X    echo exit 1 >v7
Xelif $contains SIGTSTP foo >/dev/null 2>&1 ; then
X    echo "Looks kind of like a BSD system, but we'll see..."
X    echo exit 0 >bsd
X    echo exit 1 >usg
X    echo exit 1 >v7
Xelse
X    echo "Looks kind of like a version 7 system, but we'll see..."
X    echo exit 1 >bsd
X    echo exit 1 >usg
X    echo exit 0 >v7
Xfi
Xcase "$eunicefix" in
X*unixtovms*)
X    cat <<'EOI'
XThere is, however, a strange, musty smell in the air that reminds me of
Xsomething...hmm...yes...I've got it...there's a VMS nearby, or I'm a Blit.
XEOI
X    echo "exit 0" >eunice
X    d_eunice="$define"
X    ;;
X*)
X    echo " "
X    echo "Congratulations.  You aren't running Eunice."
X    d_eunice="$undef"
X    echo "exit 1" >eunice
X    ;;
Xesac
Xif test -f /xenix; then
X    echo "Actually, this looks more like a XENIX system..."
X    echo "exit 0" >xenix
X    xenix="$define"
Xelse
X    echo " "
X    echo "It's not Xenix..."
X    echo "exit 1" >xenix
X    xenix="$undef"
Xfi
Xchmod +x xenix
X$eunicefix xenix
Xif test -f /venix; then
X    echo "Actually, this looks more like a VENIX system..."
X    echo "exit 0" >venix
Xelse
X    echo " "
X    if xenix; then
X	: null
X    else
X	echo "Nor is it Venix..."
X    fi
X    echo "exit 1" >venix
Xfi
Xchmod +x bsd usg v7 eunice venix
X$eunicefix bsd usg v7 eunice venix
Xrm -rf foo
Xrmlist="$rmlist bsd usg v7 eunice venix xenix"
X
X: Warnings
Xif v7; then
X    cat <<'EOM'
X
XNOTE: many V7 systems do not have a way to do a non-blocking read.  If you
Xdon't have any of FIONREAD, O_NDELAY, or rdchk(), the $package package
Xmay not work as well as it might.  It might not work at all.
XEOM
Xfi
X
X: see what memory models we can support
Xcase "$models" in
X'')
X    : We may not use Cppsym or we get a circular dependency through cc.
X    : But this should work regardless of which cc we eventually use.
X    cat >pdp11.c <<'EOP'
Xmain() {
X#ifdef pdp11
X    exit(0);
X#else
X    exit(1);
X#endif
X}
XEOP
X    cc -o pdp11 pdp11.c >/dev/null 2>&1
X    if pdp11 2>/dev/null; then
X	dflt='unsplit split'
X    else
X	ans=`loc . X /lib/small /lib/large /usr/lib/small /usr/lib/large /lib/medium /usr/lib/medium /lib/huge`
X	case "$ans" in
X	X) dflt='none';;
X	*)  if $test -d /lib/small || $test -d /usr/lib/small; then
X		dflt='small'
X	    else
X		dflt=''
X	    fi
X	    if $test -d /lib/medium || $test -d /usr/lib/medium; then
X		dflt="$dflt medium"
X	    fi
X	    if $test -d /lib/large || $test -d /usr/lib/large; then
X		dflt="$dflt large"
X	    fi
X	    if $test -d /lib/huge || $test -d /usr/lib/huge; then
X		dflt="$dflt huge"
X	    fi
X	esac
X    fi
X    ;;
X*)  dflt="$models" ;;
Xesac
X$cat <<EOM
X 
XSome systems have different model sizes.  On most systems they are called
Xsmall, medium, large, and huge.  On the PDP11 they are called unsplit and
Xsplit.  If your system doesn't support different memory models, say "none".
XIf you wish to force everything to one memory model, say "none" here and
Xput the appropriate flags later when it asks you for other cc and ld flags.
XVenix systems may wish to put "none" and let the compiler figure things out.
X(In the following question multiple model names should be space separated.)
X
XEOM
Xrp="Which models are supported? [$dflt]"
X$echo $n "$rp $c"
X. myread
Xmodels="$ans"
X
Xcase "$models" in
Xnone)
X    small=''
X    medium=''
X    large=''
X    huge=''
X    unsplit=''
X    split=''
X    ;;
X*split)
X    case "$split" in
X    '') dflt='-i';;
X    *) dflt="$split";;
X    esac
X    rp="What flag indicates separate I and D space? [$dflt]"
X    $echo $n "$rp $c"
X    . myread
X    case "$ans" in
X    none) ans='';;
X    esac
X    split="$ans"
X    unsplit=''
X    ;;
X*large*|*small*|*medium*|*huge*)
X    case "$models" in
X    *large*)
X	case "$large" in
X	'') dflt='-Ml';;
X	*) dflt="$large";;
X	esac
X	rp="What flag indicates large model? [$dflt]"
X	$echo $n "$rp $c"
X	. myread
X	case "$ans" in
X	none) ans='';
X	esac
X	large="$ans"
X	;;
X    *) large='';;
X    esac
X    case "$models" in
X    *huge*)
X	case "$huge" in
X	'') dflt='-Mh';;
X	*) dflt="$huge";;
X	esac
X	rp="What flag indicates huge model? [$dflt]"
X	$echo $n "$rp $c"
X	. myread
X	case "$ans" in
X	none) ans='';
X	esac
X	huge="$ans"
X	;;
X    *) huge="$large";;
X    esac
X    case "$models" in
X    *medium*)
X	case "$medium" in
X	'') dflt='-Mm';;
X	*) dflt="$medium";;
X	esac
X	rp="What flag indicates medium model? [$dflt]"
X	$echo $n "$rp $c"
X	. myread
X	case "$ans" in
X	none) ans='';
X	esac
X	medium="$ans"
X	;;
X    *) medium="$large";;
X    esac
X    case "$models" in
X    *small*)
X	case "$small" in
X	'') dflt='none';;
X	*) dflt="$small";;
X	esac
X	rp="What flag indicates small model? [$dflt]"
X	$echo $n "$rp $c"
X	. myread
X	case "$ans" in
X	none) ans='';
X	esac
X	small="$ans"
X	;;
X    *) small='';;
X    esac
X    ;;
X*)
X    echo "Unrecognized memory models--you may have to edit Makefile.SH"
X    ;;
Xesac
X
X: see if we need a special compiler
Xecho " "
Xif usg; then
X    case "$cc" in
X    '') case "$Mcc" in
X	/*) dflt='Mcc';;
X	*) dflt='cc';;
X	esac
X	;;
X    *)  dflt="$cc";;
X    esac
X    $cat <<'EOM'
X  
XOn some systems the default C compiler will not resolve multiple global
Xreferences that happen to have the same name.  On some such systems the
X"Mcc" command may be used to force these to be resolved.  On other systems
Xa "cc -M" command is required.  (Note that the -M flag on other systems
Xindicates a memory model to use!)  If you have the Gnu C compiler, you
Xmight wish to use that instead.  What command will force resolution on
XEOM
X    $echo $n "this system? [$dflt] $c"
X    rp="Command to resolve multiple refs? [$dflt]"
X    . myread
X    cc="$ans"
Xelse
X    case "$cc" in
X    '') dflt=cc;;
X    *) dflt="$cc";;
X    esac
X    rp="Use which C compiler? [$dflt]"
X    $echo $n "$rp $c"
X    . myread
X    cc="$ans"
Xfi
Xcase "$cc" in
Xgcc*) cpp=`loc gcc-cpp $cpp $pth`;;
Xesac
X
X: determine optimize, if desired, or use for debug flag also
Xcase "$optimize" in
X' ') dflt="none"
X     ;;
X'') dflt="-O";
X    ;;
X*)  dflt="$optimize"
X    ;;
Xesac
Xcat <<EOH
X
XSome C compilers have problems with their optimizers, by default, $package
Xcompiles with the -O flag to use the optimizer.  Alternately, you might
Xwant to use the symbolic debugger, which uses the -g flag (on traditional
XUnix systems).  Either flag can be specified here.  To use neither flag,
Xspecify the word "none".
X  
XEOH
Xrp="What optimizer/debugger flag should be used? [$dflt]"
X$echo $n "$rp $c"
X. myread
Xoptimize="$ans"
Xcase "$optimize" in
X'none') optimize=" "
X     ;;
Xesac
X
Xcase "$ccflags" in
X'') case "$cc" in
X    *gcc*) dflt='-fpcc-struct-return';;
X    *) dflt='';;
X    esac
X    ;;
X*) dflt="$ccflags";;
Xesac
Xfor thisincl in $inclwanted; do
X    if test -d $thisincl; then
X	case "$dflt" in
X	*$thisincl*);;
X	*) dflt="$dflt -I$thisincl";;
X	esac
X    fi
Xdone
Xcase "$optimize" in
X-g*)
X    case "$dflt" in
X    *DEBUGGING*);;
X    *) dflt="$dflt -DDEBUGGING";;
X    esac
X    ;;
Xesac
Xif $contains 'LANGUAGE_C' /usr/include/signal.h >/dev/null 2>&1; then
X    case "$dflt" in
X    *LANGUAGE_C*);;
X    *) dflt="$dflt -DLANGUAGE_C";;
X    esac
Xfi
Xcase "$dflt" in
X'') dflt=none;;
Xesac
Xcat <<EOH
X
XYour C compiler may want other flags.  For this question you should
Xinclude -I/whatever and -DWHATEVER flags and any other flags used by
Xthe C compiler, but you should NOT include libraries or ld flags like
X-lwhatever.  To use no flags, specify the word "none".
X  
XEOH
Xrp="Any additional cc flags? [$dflt]"
X$echo $n "$rp $c"
X. myread
Xcase "$ans" in
Xnone) ans='';
Xesac
Xccflags="$ans"
X
X: the following weeds options from ccflags that are of no interest to cpp
Xcppflags="$ccflags"
Xcase "$cc" in
X*gcc*) cppflags="$cppflags -D__GNUC__";;
Xesac
Xcase "$cppflags" in
X'');;
X*)  set X $cppflags
X    cppflags=''
X    for flag do
X	case $flag in
X	-D*|-I*) cppflags="$cppflags $flag";;
X	esac
X    done
X    case "$cppflags" in
X    *-*)  echo "(C preprocessor flags: $cppflags)";;
X    esac
X    ;;
Xesac
X
Xcase "$ldflags" in
X'') if venix; then
X	dflt='-i -z'
X    else
X	dflt='none'
X    fi
X    ;;
X*) dflt="$ldflags";;
Xesac
Xecho " "
Xrp="Any additional ld flags (NOT including libraries)? [$dflt]"
X$echo $n "$rp $c"
X. myread
Xcase "$ans" in
Xnone) ans='';
Xesac
Xldflags="$ans"
Xrmlist="$rmlist pdp11"
X
X: where do we get termlib routines from
Xecho " "
Xans=`loc libcurses.a x $libpth`
Xcase "$ans" in
X/*)
X    ar t $ans >grimble
X    if $contains tputs.o grimble >/dev/null 2>&1; then
X	termlib='-lcurses'
X	echo "Terminfo library found."
X    else
X	ans=x
X    fi
X    rm -f grimble
X    ;;
Xesac
Xcase "$ans" in
Xx)
X    ans=`loc libtermlib.a x $libpth`
X    case "$ans" in
X    /usr/lib*|/lib*)
X	termlib='-ltermlib'
X	echo "Termlib library found."
X	;;
X    /*)
X	termlib="$ans"
X	echo "Termlib library found."
X	;;
X    *)
X	ans=`loc libtermcap.a x $libpth`
X	case "$ans" in
X	/usr/lib*|/lib*)
X	    termlib='-ltermcap'
X	    echo "Termcap library found."
X	    ;;
X	/*)
X	    termlib="$ans"
X	    echo "Termcap library found."
X	    ;;
X	*)
X	    case "$termlib" in
X	    '')
X		dflt=y
X		rp="Your system appears to NOT have termlib-style routines.  Is this true? [$dflt]"
X		$echo $n "$rp $c"
X		. myread
X		case "$ans" in
X		    n*|f*)
X			  echo "Then where are the termlib-style routines kept (specify either -llibname"
X			  $echo $n " or full pathname (~name ok))? $c"
X			  rp='Specify termlib:'
X			  . myread
X			  termlib=`filexp $ans`
X			  ;;
X		    *)    termlib=''
X			  echo "You will have to play around with main.c then."
X			  ;;
X		esac
X		echo " "
X		;;
X	    *)  echo "You said termlib was $termlib before."
X		;;
X	    esac
X	    ;;
X	esac
X	;;
X    esac
X    ;;
Xesac
Xans=`loc llib${termlib}.ln x $libpth`
Xcase "$ans" in
X/usr/lib*|/lib*)
X    echo "Termlib lint library found."
X    llib_termlib="$termlib"
X    ;;
Xesac
X
Xecho " "
Xecho "Checking for optional libraries..."
Xdflt=''
Xcase "$libswanted" in
X'') libswanted='c_s';;
Xesac
Xfor thislib in $libswanted; do
X    case "$thislib" in
X    dbm) thatlib=ndbm;;
X    *_s) thatlib=NONE;;
X    *) thatlib="${thislib}_s";;
X    *) thatlib=NONE;;
X    esac
X    xxx=`loc lib$thislib.a X /usr/lib /usr/local/lib /lib`
X    if test -f $xxx; then
X	echo "Found -l$thislib."
X	case "$dflt" in
X	*-l$thislib*|*-l$thatlib*);;
X	*) dflt="$dflt -l$thislib";;
X	esac
X    else
X	xxx=`loc lib$thislib.a X $libpth`
X	if test -f $xxx; then
X	    echo "Found $xxx."
X	    case "$dflt" in
X	    *$xxx*);;
X	    *) dflt="$dflt $xxx";;
X	    esac
X	else
X	    xxx=`loc Slib$thislib.a X $xlibpth`
X	    if test -f $xxx; then
X		echo "Found -l$thislib."
X		case "$dflt" in
X		*-l$thislib*|*-l$thatlib*);;
X		*) dflt="$dflt -l$thislib";;
X		esac
X	    else
X		echo "No -l$thislib."
X	    fi
X	fi
X    fi
Xdone
Xset X $termlib $dflt
Xshift
Xdflt="$*"
Xcase "$libs" in
X'') dflt="$dflt";;
X*) dflt="$libs";;
Xesac
Xcase "$dflt" in
X'') dflt='none';;
Xesac
X
X$cat <<EOM
X 
XSome versions of Unix support shared libraries, which make
Xexecutables smaller but make load time slightly longer.
X
XOn some systems, mostly newer Unix System V's, the shared library
Xis included by putting the option "-lc_s" as the last thing on the
Xcc command line when linking.  Other systems use shared libraries
Xby default.  There may be other libraries needed to compile $package
Xon your machine as well.  If your system needs the "-lc_s" option,
Xinclude it here.  Include any other special libraries here as well.
XSay "none" for none.
XEOM
X
Xecho " "
Xrp="Any additional libraries? [$dflt]"
X$echo $n "$rp $c"
X. myread
Xcase "$ans" in
Xnone) ans='';
Xesac
Xlibs="$ans"
X
X: see how we invoke the C preprocessor
Xecho " "
Xecho "Now, how can we feed standard input to your C preprocessor..."
Xcat <<'EOT' >testcpp.c
X#define ABC abc
X#define XYZ xyz
XABC.XYZ
XEOT
Xecho 'Maybe "'"$cc"' -E" will work...'
X$cc -E <testcpp.c >testcpp.out 2>&1
X: try to force gcc preprocessor if that is the compiler they are using
Xcase $? in
X0) cppstdin="$cc -E";;
X*) case "$cc" in
X    *gcc*)
X	cd ..
X	echo 'Trying (cat >/tmp/$$.c; '"$cc"' -E /tmp/$$.c; rm /tmp/$$.c)'
X	echo 'cat >/tmp/$$.c; '"$cc"' -E /tmp/$$.c; rm /tmp/$$.c' >cppstdin
X	chmod 755 cppstdin
X	cppstdin=`pwd`/cppstdin
X	cppminus='';
X	cd UU
X	$cppstdin <testcpp.c >testcpp.out 2>&1
X	;;
X    esac
X    ;;
Xesac
Xif $contains 'abc.*xyz' testcpp.out >/dev/null 2>&1 ; then
X    echo "Yup, it does."
X    cppstdin="$cc -E"
X    cppminus='';
Xelse
X    echo 'Nope, maybe "'$cpp'" will work...'
X    $cpp <testcpp.c >testcpp.out 2>&1
X    if $contains 'abc.*xyz' testcpp.out >/dev/null 2>&1 ; then
X	echo "Yup, it does."
X	cppstdin="$cpp"
X	cppminus='';
X    else
X	echo 'No such luck...maybe "'$cpp' -" will work...'
X	$cpp - <testcpp.c >testcpp.out 2>&1
X	if $contains 'abc.*xyz' testcpp.out >/dev/null 2>&1 ; then
X	    echo "It works!"
X	    cppstdin="$cpp"
X	    cppminus='-';
X	else
X	    echo 'Nixed again...maybe "'"$cc"' -E -" will work...'
X	    $cc -E - <testcpp.c >testcpp.out 2>&1
X	    if $contains 'abc.*xyz' testcpp.out >/dev/null 2>&1 ; then
X		echo "Hooray, it works!  I was beginning to wonder."
X		cppstdin="$cc -E"
X		cppminus='-';
X	    else
X		echo 'Nope...maybe "'"$cc"' -P" will work...'
X		$cc -P <testcpp.c >testcpp.out 2>&1
X		if $contains 'abc.*xyz' testcpp.out >/dev/null 2>&1 ; then
X		    echo "Yup, that does."
X		    cppstdin="$cc -P"
X		    cppminus='';
X		else
X		    echo 'Nope...maybe "'"$cc"' -P -" will work...'
X		    $cc -P - <testcpp.c >testcpp.out 2>&1
X		    if $contains 'abc.*xyz' testcpp.out >/dev/null 2>&1 ; then
X			echo "Yup, that does."
X			cppstdin="$cc -P"
X			cppminus='-';
X		    else
X			echo 'Hmm...perhaps you already told me...'
X			case "$cppstdin" in
X			'') ;;
X			*) $cppstdin $cppminus <testcpp.c >testcpp.out 2>&1;;
X			esac
X			if $contains 'abc.*xyz' testcpp.out >/dev/null 2>&1 ; then
X			    echo "Hooray, you did!  I was beginning to wonder."
X			else
X			    echo 'Uh-uh.  Time to get fancy...'
X			    cd ..
X			    echo 'Trying (cat >/tmp/$$.c; '"$cc"' -E /tmp/$$.c; rm /tmp/$$.c)'
X			    echo 'cat >/tmp/$$.c; '"$cc"' -E /tmp/$$.c; rm /tmp/$$.c' >cppstdin
X			    chmod 755 cppstdin
X			    cppstdin=`pwd`/cppstdin
X			    cppminus='';
X			    cd UU
X			    $cppstdin <testcpp.c >testcpp.out 2>&1
X			    if $contains 'abc.*xyz' testcpp.out >/dev/null 2>&1 ; then
X				echo "Eureka!."
X			    else
X				dflt=blurfl
X				$echo $n "No dice.  I can't find a C preprocessor.  Name one: $c"
X				rp='Name a C preprocessor:'
X				. myread
X				cppstdin="$ans"
X				$cppstdin <testcpp.c >testcpp.out 2>&1
X				if $contains 'abc.*xyz' testcpp.out >/dev/null 2>&1 ; then
X				    echo "OK, that will do."
X				else
X				    echo "Sorry, I can't get that to work.  Go find one."
X				    exit 1
X				fi
X			    fi
X			fi
X		    fi
X		fi
X	    fi
X	fi
X    fi
Xfi
Xrm -f testcpp.c testcpp.out
X
X: get list of predefined functions in a handy place
Xecho " "
Xcase "$libc" in
X'') libc=unknown;;
Xesac
Xcase "$libpth" in
X'') libpth='/lib /usr/lib /usr/local/lib';;
Xesac
Xcase "$libs" in
X*-lc_s*) libc=`loc libc_s.a $libc $libpth`
Xesac
Xlibnames='';
Xcase "$libs" in
X'') ;;
X*)  for thislib in $libs; do
X	case "$thislib" in
X	-l*) thislib=`expr X$thislib : 'X-l\(.*\)'`
X	    try=`loc lib$thislib.a blurfl/dyick $libpth`
X	    if test ! -f $try; then
X		try=`loc lib$thislib blurfl/dyick $libpth`
X		if test ! -f $try; then
X		    try=`loc $thislib blurfl/dyick $libpth`
X		    if test ! -f $try; then
X			try=`loc Slib$thislib.a blurfl/dyick $xlibpth`
X			if test ! -f $try; then
X			    try=''
X			fi
X		    fi
X		fi
X	    fi
X	    libnames="$libnames $try"
X	    ;;
X	*) libnames="$libnames $thislib" ;;
X	esac
X    done
X    ;;
Xesac
Xset /usr/lib/libc.so.[0-9]*
Xeval set \$$#
Xif test -f "$1"; then
X    echo "Your shared C library is in $1."
X    libc="$1"
Xelif test -f $libc; then
X    echo "Your C library is in $libc, like you said before."
Xelif test -f /lib/libc.a; then
X    echo "Your C library is in /lib/libc.a.  You're normal."
X    libc=/lib/libc.a
Xelse
X    ans=`loc libc.a blurfl/dyick $libpth`
X    if test ! -f "$ans"; then
X	ans=`loc libc blurfl/dyick $libpth`
X    fi
X    if test ! -f "$ans"; then
X	ans=`loc clib blurfl/dyick $libpth`
X    fi
X    if test ! -f "$ans"; then
X	ans=`loc Slibc.a blurfl/dyick $xlibpth`
X    fi
X    if test ! -f "$ans"; then
X	ans=`loc Mlibc.a blurfl/dyick $xlibpth`
X    fi
X    if test ! -f "$ans"; then
X	ans=`loc Llibc.a blurfl/dyick $xlibpth`
X    fi
X    if test -f "$ans"; then
X	echo "Your C library is in $ans, of all places."
X	libc=$ans
X    else
X	cat <<EOM
X 
XI can't seem to find your C library.  I've looked in the following places:
X
X	$libpth
X
XNone of these seems to contain your C library.  What is the full name
XEOM
X	dflt=None
X	$echo $n "of your C library? $c"
X	rp='C library full name?'
X	. myread
X	libc="$ans"
X    fi
Xfi
Xecho " "
Xset `echo $libc $libnames | tr ' ' '\012' | sort | uniq`
X$echo $n "Extracting names from $* for later perusal...$c"
Xnm $* 2>/dev/null >libc.tmp
X$sed -n -e 's/^.* [AT]  *_[_.]*//p' -e 's/^.* [AT] //p' <libc.tmp >libc.list
Xif $contains '^printf$' libc.list >/dev/null 2>&1; then
X    echo "done"
Xelse
X    $sed -n -e 's/^__*//' -e 's/^\([a-zA-Z_0-9$]*\).*xtern.*/\1/p' <libc.tmp >libc.list
X    $contains '^printf$' libc.list >/dev/null 2>&1 || \
X	$sed -n -e '/|UNDEF/d' -e '/FUNC..GL/s/^.*|__*//p' <libc.tmp >libc.list
X    $contains '^printf$' libc.list >/dev/null 2>&1 || \
X	$sed -n -e 's/^.* D __*//p' -e 's/^.* D //p' <libc.tmp >libc.list
X    $contains '^printf$' libc.list >/dev/null 2>&1 || \
X       $sed -n -e 's/^_//' \
X	      -e 's/^\([a-zA-Z_0-9]*\).*xtern.*text.*/\1/p' <libc.tmp >libc.list
X    $contains '^printf$' libc.list >/dev/null 2>&1 || \
X	$sed -n -e 's/^.*|FUNC |GLOB .*|//p' <libc.tmp >libc.list
X    if $contains '^printf$' libc.list >/dev/null 2>&1; then
X	echo "done"
X    else
X	echo " "
X	echo "nm didn't seem to work right."
X	echo "Trying ar instead..."
X	if ar t $libc > libc.tmp; then
X	    for thisname in $libnames; do
X		ar t $thisname >>libc.tmp
X	    done
X	    $sed -e 's/\.o$//' < libc.tmp > libc.list
X	    echo "Ok."
X	else
X	    echo "ar didn't seem to work right."
X	    echo "Maybe this is a Cray...trying bld instead..."
X	    if bld t $libc | $sed -e 's/.*\///' -e 's/\.o:.*$//' > libc.list; then
X		for thisname in $libnames; do
X		    bld t $libnames | \
X			$sed -e 's/.*\///' -e 's/\.o:.*$//' >>libc.list
X		    ar t $thisname >>libc.tmp
X		done
X		echo "Ok."
X	    else
X	    	echo "That didn't work either.  Giving up."
X	    	exit 1
X	    fi
X	fi
X    fi
Xfi
Xrmlist="$rmlist libc.tmp libc.list"
X
X: see if this is an fcntl system
Xecho " "
Xif $test -r /usr/include/fcntl.h ; then
X    d_fcntl="$define"
X    i_fcntl="$define"
X    echo "fcntl.h found."
Xelse
X    d_fcntl="$undef"
X    i_fcntl="$undef"
X    echo "No fcntl.h found, but that's ok."
Xfi
X
X: index or strcpy
Xecho " "
Xcase "$d_index" in
Xn) dflt=n;;
X*) dflt=y;;
Xesac
Xif $contains '^index$' libc.list >/dev/null 2>&1 ; then
X    if $contains '^strchr$' libc.list >/dev/null 2>&1 ; then
X	echo "Your system has both index() and strchr().  Shall I use"
X	rp="index() rather than strchr()? [$dflt]"
X	$echo $n "$rp $c"
X	. myread
X	case "$ans" in
X	    n*) d_index="$define" ;;
X	    *)  d_index="$undef" ;;
X	esac
X    else
X	d_index="$undef"
X	echo "index() found."
X    fi
Xelse
X    if $contains '^strchr$' libc.list >/dev/null 2>&1 ; then
X	d_index="$define"
X	echo "strchr() found."
X    else
X	d_index="$undef"
X	echo "No index() or strchr() found!"
X    fi
Xfi
X
X: see if ioctl defs are in termio or sys/ioctl
Xecho " "
Xif $test -r /usr/include/sys/ioctl.h ; then
X    d_ioctl="$define"
X    i_sysioctl="$define"
X    echo "sys/ioctl.h found."
Xelse
X    d_ioctl="$undef"
X    i_sysioctl="$undef"
X    echo "sys/ioctl.h not found, assuming ioctl args are defined in termio.h."
Xfi
X
X: see if this is a pwd system
Xecho " "
Xif $test -r /usr/include/pwd.h ; then
X    i_pwd="$define"
X    echo "pwd.h found."
Xelse
X    i_pwd="$undef"
X    echo "No pwd.h found."
Xfi
X
X: see if we should include time.h, sys/time.h, or both
Xcat <<'EOM'
X  
XTesting to see if we should include <time.h>, <sys/time.h> or both.
XI'm now running the test program...
XEOM
X$cat >try.c <<'EOCP'
X#ifdef I_TIME
X#include <time.h>
X#endif
X#ifdef I_SYSTIME
X#ifdef SYSTIMEKERNEL
X#define KERNEL
X#endif
X#include <sys/time.h>
X#endif
Xmain()
X{
X    struct tm foo;
X#ifdef S_TIMEVAL
X    struct timeval bar;
X#endif
X    if (foo.tm_sec == foo.tm_sec)
X	exit(0);
X#ifdef S_TIMEVAL
X    if (bar.tv_sec == bar.tv_sec)
X	exit(0);
X#endif
X    exit(1);
X}
XEOCP
Xflags=''
Xfor s_timeval in '-DS_TIMEVAL' ''; do
X    for d_systimekernel in '' '-DSYSTIMEKERNEL'; do
X	for i_time in '' '-DI_TIME'; do
X	    for i_systime in '-DI_SYSTIME' ''; do
X		case "$flags" in
X		'') echo Trying $i_time $i_systime $d_systimekernel $s_timeval
X		    if $cc $ccflags \
X			    $i_time $i_systime $d_systimekernel $s_timeval \
X			    try.c -o try >/dev/null 2>&1 ; then
X			set X $i_time $i_systime $d_systimekernel $s_timeval
X			shift
X			flags="$*"
X			echo Succeeded with $flags
X		    fi
X		    ;;
X		esac
X	    done
X	done
X    done
Xdone
Xcase "$flags" in
X*SYSTIMEKERNEL*) d_systimekernel="$define";;
X*) d_systimekernel="$undef";;
Xesac
Xcase "$flags" in
X*I_TIME*) i_time="$define";;
X*) i_time="$undef";;
Xesac
Xcase "$flags" in
X*I_SYSTIME*) i_systime="$define";;
X*) i_systime="$undef";;
Xesac
X$rm -f try.c try
X
X: see if this is a varargs system
Xecho " "
Xif $test -r /usr/include/varargs.h ; then
X    d_varargs="$define"
X    echo "varargs.h found."
Xelse
X    d_varargs="$undef"
X    echo "No varargs.h found, but that's ok (I hope)."
Xfi
X
X: see if signal is declared as pointer to function returning int or void
Xecho " "
X$cppstdin $cppflags < /usr/include/signal.h >$$.tmp
Xif $contains 'void.*signal' $$.tmp >/dev/null 2>&1 ; then
X    echo "You have void (*signal())() instead of int."
X    d_voidsig="$define"
Xelse
X    echo "You have int (*signal())() instead of void."
X    d_voidsig="$undef"
Xfi
Xrm -f $$.tmp
X
X: check for void type
Xecho " "
X$cat <<EOM
XChecking to see how well your C compiler groks the void type...
X
X  Support flag bits are:
X    1: basic void declarations.
X    2: arrays of pointers to functions returning void.
X    4: operations between pointers to and addresses of void functions.
X
XEOM
Xcase "$voidflags" in
X'')
X    $cat >try.c <<'EOCP'
X#if TRY & 1
Xvoid main() {
X#else
Xmain() {
X#endif
X	extern void moo();	/* function returning void */
X	void (*goo)();		/* ptr to func returning void */
X#if TRY & 2
X	void (*foo[10])();
X#endif
X
X#if TRY & 4
X	if(goo == moo) {
X		exit(0);
X	}
X#endif
X	exit(0);
X}
XEOCP
X    if $cc $ccflags -c -DTRY=$defvoidused try.c >.out 2>&1 ; then
X	voidflags=$defvoidused
X	echo "It appears to support void."
X	if $contains warning .out >/dev/null 2>&1; then
X	    echo "However, you might get some warnings that look like this:"
X	    $cat .out
X	fi
X    else
X	echo "Hmm, your compiler has some difficulty with void.  Checking further..."
X	if $cc $ccflags -c -DTRY=1 try.c >/dev/null 2>&1 ; then
X	    echo "It supports 1..."
X	    if $cc $ccflags -c -DTRY=3 try.c >/dev/null 2>&1 ; then
X		voidflags=3
X		echo "And it supports 2 but not 4."
X	    else
X		echo "It doesn't support 2..."
X		if $cc $ccflags -c -DTRY=5 try.c >/dev/null 2>&1 ; then
X		    voidflags=5
X		    echo "But it supports 4."
X		else
X		    voidflags=1
X		    echo "And it doesn't support 4."
X		fi
X	    fi
X	else
X	    echo "There is no support at all for void."
X	    voidflags=0
X	fi
X    fi
Xesac
Xdflt="$voidflags";
Xrp="Your void support flags add up to what? [$dflt]"
X$echo $n "$rp $c"
X. myread
Xvoidflags="$ans"
X$rm -f try.* .out
X
X: see what type uids are declared as in the kernel
Xcase "$uidtype" in
X'')
X    if $contains 'uid_t;' /usr/include/sys/types.h >/dev/null 2>&1 ; then
X	dflt='uid_t'
X    else
X	set `grep 'u_uid;' /usr/include/sys/user.h 2>/dev/null` unsigned short
X	case $1 in
X	unsigned) dflt="$1 $2" ;;
X	*) dflt="$1" ;;
X	esac
X    fi
X    ;;
X*)  dflt="$uidtype"
X    ;;
Xesac
Xcont=true
Xecho " "
Xrp="What type are user ids returned by getuid(), etc.? [$dflt]"
X$echo $n "$rp $c"
X. myread
Xuidtype="$ans"
X
X: see what type gids are declared as in the kernel
Xcase "$gidtype" in
X'')
X    if $contains 'gid_t;' /usr/include/sys/types.h >/dev/null 2>&1 ; then
X	dflt='gid_t'
X    else
X	set `grep 'u_gid;' /usr/include/sys/user.h 2>/dev/null` unsigned short
X	case $1 in
X	unsigned) dflt="$1 $2" ;;
X	*) dflt="$1" ;;
X	esac
X    fi
X    ;;
X*)  dflt="$gidtype"
X    ;;
Xesac
Xcont=true
Xecho " "
Xrp="What type are group ids returned by getgid(), etc.? [$dflt]"
X$echo $n "$rp $c"
X. myread
Xgidtype="$ans"
X
X: see if this is a varargs system
Xecho " "
Xif $test -r /usr/include/varargs.h ; then
X    i_varargs="$define"
X    echo "varargs.h found."
Xelse
X    i_varargs="$undef"
X    echo "No varargs.h found, but that's ok (I hope)."
Xfi
X
X: see what type of char stdio uses.
Xecho " "
Xif $contains 'unsigned.*char.*_ptr.*;' /usr/include/stdio.h >/dev/null 2>&1 ; then
X    echo "Your stdio uses unsigned chars."
X    stdchar="unsigned char"
Xelse
X    echo "Your stdio uses signed chars."
X    stdchar="char"
Xfi
X
X: see if there is the getut family
Xecho " "
Xif $contains '^getut' libc.list >/dev/null 2>&1 ; then
X    echo "getutent() found."
X    d_getutent="$define"
Xelse
X    echo "No getutent() found--will use my own."
X    d_getutent="$undef"
Xfi
X
X: see if there is a strdup
Xif $contains '^strdup$' libc.list >/dev/null 2>&1 ; then
X    echo "strdup() found."
X    d_strdup="$define"
Xelse
X    echo "No strdup() found--will use my own."
X    d_strdup="$undef"
Xfi
X
X: see if there is a putenv
Xif $contains '^putenv$' libc.list >/dev/null 2>&1 ; then
X    echo "putenv() found."
X    d_putenv="$define"
Xelse
X    echo "No putenv() found--will use my own."
X    d_putenv="$undef"
Xfi
X
X: now get the host name
Xecho " "
Xecho "Figuring out host name..."
Xecho 'Maybe "hostname" will work...'
Xif ans=`sh -c hostname 2>&1` ; then
X    hostname=$ans
X    phostname=hostname
Xelse
X    echo 'Oh, dear.  Maybe "/etc/systemid" is the key...'
X    if ans=`cat /etc/systemid 2>&1` ; then
X	hostname=$ans
X	phostname='cat /etc/systemid'
X	if xenix; then
X	    echo "Whadyaknow.  Xenix always was a bit strange..."
X	else
X	    echo "What is a non-Xenix system doing with /etc/systemid?"
X	fi
X    else
X	echo 'No, maybe "uuname -l" will work...'
X	if ans=`sh -c 'uuname -l' 2>&1` ; then
X	    hostname=$ans
X	    phostname='uuname -l'
X	else
X	    echo 'Strange.  Maybe "uname -n" will work...'
X	    if ans=`sh -c 'uname -n' 2>&1` ; then
X		hostname=$ans
X		phostname='uname -n'
X	    else
X		echo 'Oh well, maybe I can mine it out of whoami.h...'
X		if ans=`sh -c $contains' sysname /usr/include/whoami.h' 2>&1` ; then
X		    hostname=`echo "$ans" | $sed 's/^.*"\(.*\)"/\1/'`
X		    phostname="sed -n -e '"'/sysname/s/^.*\"\\(.*\\)\"/\1/{'"' -e p -e q -e '}' </usr/include/whoami.h"
X		else
X		    case "$hostname" in
X		    '') echo "Does this machine have an identity crisis or something?"
X			phostname=''
X			;;
X		    *)  echo "Well, you said $hostname before...";;
X		    esac
X		fi
X	    fi
X	fi
X    fi
Xfi
X: you do not want to know about this
Xset $hostname
Xhostname=$1
X
X: translate upper to lower if necessary
Xcase "$hostname" in
X    *[A-Z]*)
X	hostname=`echo $hostname | $tr '[A-Z]' '[a-z]'`
X	echo "(Normalizing case in your host name)"
X	;;
Xesac
X
X: verify guess
Xif $test "$hostname" ; then
X    dflt=y
X    echo 'Your host name appears to be "'$hostname'".'
X    $echo $n "Is this correct? [$dflt] $c"
X    rp="Sitename is $hostname? [$dflt]"
X    . myread
X    case "$ans" in
X      y*)  ;;
X      *)      hostname='' ;;
X    esac
Xfi
X
X: bad guess or no guess
Xwhile $test "X$hostname" = X ; do
X    dflt=''
X    rp="Please type the (one word) name of your host:"
X    $echo $n "$rp $c"
X    . myread
X    hostname="$ans"
Xdone
X
X: a little sanity check here
Xcase "$phostname" in
X'') ;;
X*)  case `$phostname` in
X    $hostname) ;;
X    *)
X	case "$phostname" in
X	sed*)
X	    echo "(That doesn't agree with your whoami.h file, by the way.)"
X	    ;;
X	*)
X	    echo "(That doesn't agree with your $phostname command, by the way.)"
X	    ;;
X	esac
X	phostname=''
X	;;
X    esac
X    ;;
Xesac
X
X: see how we will look up host name
Xd_douname="$undef"
Xd_phostname="$undef"
X
X# if xenix; then
X#     echo " "
X#     echo "(Assuming Xenix uname() is broken.)"
X# el
Xif $contains '^uname$' libc.list >/dev/null 2>&1 ; then
X    echo "uname() found."
X    d_douname="$define"
X    ans=uname
Xfi
X
Xcase "$d_douname" in
X*define*)
X    dflt=n
X    cat <<EOM
X 
XEvery now and then someone has a $ans() that lies about the hostname
Xbut can't be fixed for political or economic reasons.  Would you like to
XEOM
X    rp="pretend $ans() isn't there and maybe compile in the hostname? [$dflt]"
X    $echo $n "$rp $c"
X    . myread
X    case "$ans" in
X    y*) d_douname="$undef"
X	$echo $n "Okay... $c"
X	;;
X    esac
X    ;;
Xesac
X
Xcase "$d_douname" in
X*define*) ;;
X*)
X    case "$phostname" in
X      '') ;;
X      *)
X	$cat <<EOT
X 
XThere is no uname() on this system.  You have two possibilities at this point:
X
X1)  You can have your host name ($hostname) compiled into $package, which
X    lets $package start up faster, but makes your binaries non-portable, or
X2)  you can have $package use a
X	
X	popen("$phostname","r")
X
X    which will start slower but be more portable.
X
XOption 1 will give you the option of using whoami.h if you have one.  If you
Xwant option 2 but with a different command, you can edit config.sh at the
Xend of this shell script.
X
XEOT
X	case "$d_phostname" in
X	"$define") dflt=n;;
X	"$undef")  dflt=y;;
X	'')
X	    case "$d_portable" in
X	    "$define") dflt=n ;;
X	    *)      dflt=y ;;
X	    esac
X	    ;;
X	esac
X	rp="Do you want your host name compiled in? [$dflt]"
X	$echo $n "$rp $c"
X	. myread
X	case "$ans" in
X	  n*) d_phostname="$define" ;;
X	  *)  phostname=''
X	      d_phostname="$undef"
X	      ;;
X	esac
X	;;
X    esac
X    case "$phostname" in
X      '')
X	case "$d_whoami" in
X	  "$define")
X	    dflt=y
X	    $cat <<EOM
X 
XNo hostname function--you can either use the whoami.h file, which has this line:
X
X	`grep sysname /usr/include/whoami.h`
X
Xor you can have the name we came up with earlier ($hostname) hardwired in.
XEOM
X	    rp="Use whoami.h to get hostname? [$dflt]"
X	    $echo $n "$rp $c"
X	    . myread
X	    case "$ans" in
X	    n*) d_whoami="$undef";;
X	    esac
X	    ;;
X	  "$undef")
X	    echo 'No hostname function and no whoami.h--hardwiring "'$hostname'".'
X	    ;;
X	esac
X	;;
X    esac
X    ;;
Xesac
X
X: see if there is a ttytype file
Xecho " "
Xif ttytype=`loc ttytype x /etc`; then
X    echo "Found $ttytype."
X    d_ttytype="$define"
Xelse
X    d_ttytype="$undef"
Xfi
X
X: see if there is a gettydefs file
Xif gettytab=`loc gettydefs x /etc`; then
X    echo "Found $gettytab."
Xelse
X    dflt=/etc/gettydefs
X    echo " "
X    $echo "No /etc/gettydefs found.  I'll let you create your own."
X    $echo $n "What do you want to call your gettytab file? [$dflt] $c"
X    rp='Specify gettytab:'
X    . myread
X    gettytab=$ans
X    echo " "
Xfi
X
X: find the utmp file
Xif utmp=`loc utmp utmp /etc /usr/adm`; then
X    echo "Found $utmp."
Xelse
X    dflt=/etc/utmp
X    echo " "
X    $echo $n "Where is your utmp file? [$dflt] $c"
X    rp="Utmp filename? [$dflt]"
X    . myread
X    utmp="$ans"
X    echo " "
Xfi
X
X: find the wtmp file
Xif wtmp=`loc wtmp wtmp /etc /usr/adm`; then
X    echo "Found $wtmp."
Xelse
X    dflt=/etc/wtmp
X    echo " "
X    $echo $n "Where is your wtmp file? [$dflt] $c"
X    rp="Wtmp filename? [$dflt]"
X    . myread
X    wtmp="$ans"
X    echo " "
Xfi
X
X: decide how portable to be
Xcase "$d_portable" in
X"$define") dflt=y;;
X*)	dflt=n;;
Xesac
X$cat <<EOH
X 
XI can set things up so that your $package binaries are more portable,
Xat what may be a noticable cost in performance.  In particular, if you
Xask to be portable, the system name will be determined at run time,
Xif at all possible.
X
XEOH
Xrp="Do you expect to run the $package binaries on multiple machines? [$dflt]"
X$echo $n "$rp $c"
X. myread
Xcase "$ans" in
X    y*) d_portable="$define" ;;
X    *)  d_portable="$undef" ;;
Xesac
X
X: determine uucp id
Xecho " "
Xuucpid=`$sed -e "/uucp:/{s/^[^:]*:[^:]*:\([^:]*\).*"'$'"/\1/" -e "q" -e "}" -e "d" </etc/passwd`
Xcase "$uucpid" in
X  '') uucpid=0 ;;
X  *)  echo "uucp uid = $uucpid" ;;
Xesac
X
X: determine uucp lock files scheme
Xcase "$lock" in
X'')
X    if $test -d /usr/spool/locks; then
X	dflt=/usr/spool/locks
X    else
X	dflt=/usr/spool/uucp
X    fi
X    ;;
X*)  dflt="$lock";;
Xesac
Xcont=true
Xwhile $test "$cont" ; do
X    echo " "
X    $echo $n "Directory where UUCP lock files live: [$dflt] $c"
X    rp="Directory for UUCP lock files: [$dflt]"
X    . myread
X    lock="$ans"
X    if test -d $ans; then
X	cont=''
X    else
X	dflt=n
X	rp="Directory $ans doesn't exist.  Use that name anyway? [$dflt]"
X	$echo $n "$rp $c"
X	. myread
X	dflt=''
X	case "$ans" in
X	y*) cont='';;
X	esac
X    fi
Xdone
X
Xecho " "
Xcase "$d_asciipid" in
X"$define") dflt=y;;
X*)	dflt=n;;
Xesac
Xecho "The PID of the locking process is kept in the lock file."
X$echo $n "Does your UUCP store the PID in ASCII format? [$dflt] $c"
Xrp="PID stored in ASCII? [$dflt]"
X. myread
Xcase "$ans" in
Xy*) d_asciipid="$define";;
X*) d_asciipid="$undef";;
Xesac
X
X: determine mailer to use
Xcase "$mailer" in
X'')
X    if $test -f $sendmail; then
X	dflt=$sendmail
X    elif Cppsym M_XENIX; then
X	dflt=/usr/lib/mail/execmail
X    elif $test -f $mailx; then
X	dflt="$mailx"
X    else
X	dflt=$mail
X    fi
X    ;;
X*)  dflt="$mailer";;
Xesac
Xcont=true
Xwhile $test "$cont" ; do
X    echo " "
X    echo "Give the full path name of the program used to deliver mail on your"
X    $echo $n "system: [$dflt] $c"
X    rp="Preferred mailer: [$dflt]"
X    . myread
X    mailer="$ans"
X    if test -f $ans; then
X	cont=''
X    else
X	dflt=n
X	rp="File $ans doesn't exist.  Use that name anyway? [$dflt]"
X	$echo $n "$rp $c"
X	. myread
X	dflt=''
X	case "$ans" in
X	y*) cont='';;
X	esac
X    fi
Xdone
X
X: preserve RCS keywords in files with variable substitution, grrr
XId='$Id'
XHeader='$Header'
X
Xecho " "
Xecho "End of configuration questions."
Xecho " "
X
X: create config.sh file
Xecho " "
Xif test -d ../UU; then
X    cd ..
Xfi
Xecho "Creating config.sh..."
X$spitshell <<EOT >config.sh
X$startsh
X# config.sh
X# This file was produced by running the Configure script.
X
Xd_getutent='$d_getutent'
Xd_strdup='$d_strdup'
Xd_putenv='$d_putenv'
Xd_ttytype='$d_ttytype'
Xttytype='$ttytype'
Xgettytab='$gettytab'
Xutmp='$utmp'
Xwtmp='$wtmp'
Xuucpid='$uucpid'
Xlock='$lock'
Xd_asciipid='$d_asciipid'
Xmailer='$mailer'
Xhostname='$hostname'
Xphostname='$phostname'
Xd_douname='$d_douname'
Xd_phostname='$d_phostname'
Xd_portable='$d_portable'
Xtermlib='$termlib'
Xllib_termlib='$llib_termlib'
Xxenix='$xenix'
Xd_eunice='$d_eunice'
Xdefine='$define'
Xundef='$undef'
Xeunicefix='$eunicefix'
Xloclist='$loclist'
Xexpr='$expr'
Xsed='$sed'
Xecho='$echo'
Xcat='$cat'
Xrm='$rm'
Xmv='$mv'
Xcp='$cp'
Xtr='$tr'
Xsort='$sort'
Xuniq='$uniq'
Xgrep='$grep'
Xtrylist='$trylist'
Xtest='$test'
Xegrep='$egrep'
XMcc='$Mcc'
Xcpp='$cpp'
Xmail='$mail'
Xmailx='$mailx'
Xsendmail='$sendmail'
Xuname='$uname'
Xuuname='$uuname'
XLog='$Log'
XId='$Id'
Xbin='$bin'
Xcontains='$contains'
Xcppstdin='$cppstdin'
Xcppminus='$cppminus'
Xd_fcntl='$d_fcntl'
Xd_index='$d_index'
Xd_ioctl='$d_ioctl'
Xd_varargs='$d_varargs'
Xd_voidsig='$d_voidsig'
Xgidtype='$gidtype'
Xi_fcntl='$i_fcntl'
Xi_pwd='$i_pwd'
Xi_sysioctl='$i_sysioctl'
Xi_time='$i_time'
Xi_systime='$i_systime'
Xd_systimekernel='$d_systimekernel'
Xi_varargs='$i_varargs'
Xlibc='$libc'
Xmodels='$models'
Xsplit='$split'
Xsmall='$small'
Xmedium='$medium'
Xlarge='$large'
Xhuge='$huge'
Xoptimize='$optimize'
Xccflags='$ccflags'
Xcppflags='$cppflags'
Xldflags='$ldflags'
Xcc='$cc'
Xlibs='$libs'
Xn='$n'
Xc='$c'
Xpackage='$package'
Xspitshell='$spitshell'
Xshsharp='$shsharp'
Xsharpbang='$sharpbang'
Xstartsh='$startsh'
Xstdchar='$stdchar'
Xuidtype='$uidtype'
Xvoidflags='$voidflags'
Xdefvoidused='$defvoidused'
Xlib='$lib'
XCONFIG=true
XEOT
X
XCONFIG=true
X
Xecho " "
Xdflt=''
Xfastread=''
Xecho "If you didn't make any mistakes, then just type a carriage return here."
Xrp="If you need to edit config.sh, do it as a shell escape here:"
X$echo $n "$rp $c"
X. UU/myread
Xcase "$ans" in
X'') ;;
X*) : in case they cannot read
X    eval $ans;;
Xesac
X: if this fails, just run all the .SH files by hand
X. ./config.sh
X
Xecho " "
Xecho "Doing variable substitutions on .SH files..."
Xset x `awk '{print $1}' <MANIFEST | $grep '\.SH'`
Xshift
Xcase $# in
X0) set x *.SH; shift;;
Xesac
Xif test ! -f $1; then
X    shift
Xfi
Xfor file in $*; do
X    case "$file" in
X    */*)
X	dir=`$expr X$file : 'X\(.*\)/'`
X	file=`$expr X$file : 'X.*/\(.*\)'`
X	(cd $dir && . $file)
X	;;
X    *)
X	. $file
X	;;
X    esac
Xdone
Xif test -f config.h.SH; then
X    if test ! -f config.h; then
X	: oops, they left it out of MANIFEST, probably, so do it anyway.
X	. config.h.SH
X    fi
Xfi
X
Xif $contains '^depend:' Makefile >/dev/null 2>&1; then
X    dflt=n
X    $cat <<EOM
X
XNow you need to generate make dependencies by running "make depend".
XYou might prefer to run it in background: "make depend > makedepend.out &"
XIt can take a while, so you might not want to run it right now.
X
XEOM
X    rp="Run make depend now? [$dflt]"
X    $echo $n "$rp $c"
X    . UU/myread
X    case "$ans" in
X    y*) make depend && echo "Now you must run a make."
X	;;
X    *)  echo "You must run 'make depend' then 'make'."
X	;;
X    esac
Xelif test -f Makefile; then
X    echo " "
X    echo "Now you must run a make."
Xelse
X    echo "Done."
Xfi
X
X$rm -f kit*isdone
X: the following is currently useless
Xcd UU && $rm -f $rmlist
X: since this removes it all anyway
Xcd .. && $rm -rf UU
X: end of Configure
!STUFFY!FUNK!
echo ""
echo "End of kit 2 (of 5)"
cat /dev/null >kit2isdone
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
