:
# $Id: makedep.SH,v 2.0 90/09/19 20:04:37 paul Rel $
#
# $Log:	makedep.SH,v $
# Revision 2.0  90/09/19  20:04:37  paul
# Initial 2.0 release
# 
# 

case $CONFIG in
'')
    if test ! -f config.sh; then
	ln ../config.sh . || \
	ln ../../config.sh . || \
	ln ../../../config.sh . || \
	(echo "Can't find config.sh."; exit 1)
    fi
    . ./config.sh
    ;;
esac
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Extracting makedep (with variable substitutions)"
$spitshell >makedep <<!GROK!THIS!
$startsh
#
# makedep
#
# Creates dependencies for Makefile
#

export PATH || (echo "OOPS, this isn't sh.  Desperation time.  I will feed myself to sh."; sh \$0; kill \$\$)

cat='$cat'
ccflags='$ccflags'
cp='$cp'
cpp='$cppstdin'
echo='$echo'
egrep='$egrep'
expr='$expr'
mv='$mv'
rm='$rm'
sed='$sed'
sort='$sort'
test='$test'
tr='$tr'
uniq='$uniq'
!GROK!THIS!

$spitshell >>makedep <<'!NO!SUBS!'

: the following weeds options from ccflags that are of no interest to cpp
case "$ccflags" in
'');;
*)  set X $ccflags
    ccflags=''
    for flag do
	case $flag in
	-D*|-I*) ccflags="$ccflags $flag";;
	esac
    done
    ;;
esac

$cat /dev/null >.deptmp
$rm -f *.c.c c/*.c.c
if test -f Makefile; then
    mf=Makefile
else
    mf=makefile
fi
if test -f $mf; then
    defrule=`<$mf sed -n		\
	-e '/^\.c\.o:.*;/{'		\
	-e    's/\$\*\.c//'		\
	-e    's/^[^;]*;[	 ]*//p'	\
	-e    q				\
	-e '}'				\
	-e '/^\.c\.o: *$/{'		\
	-e    N				\
	-e    's/\$\*\.c//'		\
	-e    's/^.*\n[	 ]*//p'		\
	-e    q				\
	-e '}'`
fi
case "$defrule" in
'') defrule='$(CC) -c $(CFLAGS)' ;;
esac

make clist || ($echo "Searching for .c files..."; \
	$echo *.c | $tr ' ' '\012' | $egrep -v '\*' >.clist)
for file in `$cat .clist`; do
# for file in `cat /dev/null`; do
    case "$file" in
    *.c) filebase=`basename $file .c` ;;
    *.y) filebase=`basename $file .c` ;;
    esac
    $echo "Finding dependencies for $filebase.o."
    $sed -n <$file >$file.c \
	-e "/^${filebase}_init(/q" \
	-e '/^#/{' \
	-e 's|/\*.*$||' \
	-e 's|\\$||' \
	-e p \
	-e '}'
    $cpp -I. $ccflags $file.c | \
    $sed \
	-e '/^# *[0-9]/!d' \
	-e 's/^.*"\(.*\)".*$/'$filebase'.o: \1/' \
	-e 's|: \./|: |' \
	-e 's|\.c\.c|.c|' | \
    $uniq | $sort | $uniq >> .deptmp
done

$sed <Makefile >Makefile.new -e '1,/^# AUTOMATICALLY/!d'

make shlist || ($echo "Searching for .SH files..."; \
	$echo *.SH | $tr ' ' '\012' | $egrep -v '\*' >.shlist)
if $test -s .deptmp; then
    for file in `cat .shlist`; do
	$echo `$expr X$file : 'X\(.*\).SH`: $file config.sh \; \
	    /bin/sh $file >> .deptmp
    done
    $echo "Updating Makefile..."
    $echo "# If this runs make out of memory, delete /usr/include lines." \
	>> Makefile.new
    $sed 's|^\(.*\.o:\) *\(.*/.*\.c\) *$|\1 \2; '"$defrule \2|" .deptmp \
       >>Makefile.new
else
    make hlist || ($echo "Searching for .h files..."; \
	$echo *.h | $tr ' ' '\012' | $egrep -v '\*' >.hlist)
    $echo "You don't seem to have a proper C preprocessor.  Using grep instead."
    $egrep '^#include ' `cat .clist` `cat .hlist`  >.deptmp
    $echo "Updating Makefile..."
    <.clist $sed -n							\
	-e '/\//{'							\
	-e   's|^\(.*\)/\(.*\)\.c|\2.o: \1/\2.c; '"$defrule \1/\2.c|p"	\
	-e   d								\
	-e '}'								\
	-e 's|^\(.*\)\.c|\1.o: \1.c|p' >> Makefile.new
    <.hlist $sed -n 's|\(.*/\)\(.*\)|s= \2= \1\2=|p' >.hsed
    <.deptmp $sed -n 's|c:#include "\(.*\)".*$|o: \1|p' | \
       $sed 's|^[^;]*/||' | \
       $sed -f .hsed >> Makefile.new
    <.deptmp $sed -n 's|c:#include <\(.*\)>.*$|o: /usr/include/\1|p' \
       >> Makefile.new
    <.deptmp $sed -n 's|h:#include "\(.*\)".*$|h: \1|p' | \
       $sed -f .hsed >> Makefile.new
    <.deptmp $sed -n 's|h:#include <\(.*\)>.*$|h: /usr/include/\1|p' \
       >> Makefile.new
    for file in `$cat .shlist`; do
	$echo `$expr X$file : 'X\(.*\).SH`: $file config.sh \; \
	    /bin/sh $file >> Makefile.new
    done
fi
$rm -f Makefile.old
$cp Makefile Makefile.old
$cp Makefile.new Makefile
$rm Makefile.new
$echo "# WARNING: Put nothing here or make depend will gobble it up!" >> Makefile
$rm -f .deptmp `sed 's/\.c/.c.c/' .clist` .shlist .clist .hlist .hsed

!NO!SUBS!
$eunicefix makedep
chmod +x makedep
case `pwd` in
*SH)
    $rm -f ../makedep
    ln makedep ../makedep
    ;;
esac
