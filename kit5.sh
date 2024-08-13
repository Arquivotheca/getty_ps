#! /bin/sh

# Make a new directory for the getty sources, cd to it, and run kits 1
# thru 5 through sh.  When all 5 kits have been run, read README.

echo "This is getty 2.0 kit 5 (of 5).  If kit 5 is complete, the line"
echo '"'"End of kit 5 (of 5)"'" will echo at the end.'
echo ""
export PATH || (echo "You didn't use sh, you clunch." ; kill $$)
mkdir  2>/dev/null
echo Extracting strdup.c
sed >strdup.c <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: strdup.c,v 2.0 90/09/19 20:18:12 paul Rel $
X**
X**	Implements strdup(3c) [strdup(S) for you Xenix-types].
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
X**	$Log:	strdup.c,v $
X**	Revision 2.0  90/09/19  20:18:12  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X#if defined(RCSID) && !defined(lint)
Xstatic char *RcsId =
X"@(#)$Id: strdup.c,v 2.0 90/09/19 20:18:12 paul Rel $";
X#endif
X
X/*
X**	strdup() - duplicates string s in memory.
X**
X**	Returns a pointer to the new string, or NULL if an error occurrs.
X*/
X
Xchar *
Xstrdup(s)
Xregister char *s;
X{
X	register char *p = (char *) NULL;
X
X	if (s != (char *) NULL)
X		if ((p = malloc((unsigned) (strlen(s)+1))) != (char *) NULL)
X			(void) strcpy(p, s);
X
X	return(p);
X}
X
X
X/* end of strdup.c */
!STUFFY!FUNK!
echo Extracting defaults.h
sed >defaults.h <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: defaults.h,v 2.0 90/09/19 19:45:49 paul Rel $
X**
X**	Defines the structures and functions used to read runtime
X**	defaults.
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
X**	$Log:	defaults.h,v $
X**	Revision 2.0  90/09/19  19:45:49  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X/* lines in defaults file are in the form "NAME=value"
X */
X
Xtypedef struct Default {
X	char	*name;		/* name of the default */
X	char	*value;		/* value of the default */
X} DEF;
X
X
XDEF	**defbuild();		/* user-level routines */
Xchar	*defvalue();
X
XFILE	*defopen();		/* low-level routines */
XDEF	*defread();
Xint	defclose();
X
X
X/* end of defaults.h */
!STUFFY!FUNK!
echo Extracting funcs.h
sed >funcs.h <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: funcs.h,v 2.0 90/09/19 19:56:17 paul Rel $
X**
X**	Defines the miscellaneous functions.
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
X**	$Log:	funcs.h,v $
X**	Revision 2.0  90/09/19  19:56:17  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X/*	States for settermio()
X */
X#define	INITIAL	 0
X#define	FINAL	 1
X
X/*	Return values for getlogname()
X */
X#define	BADSPEED 1
X#define	BADCASE	 2
X#define	NONAME	 3
X
Xint	Fputs(), chat(), getlogname();
Xchar	*getuname();
Xvoid	settermio(), logerr();
X
X#ifdef	DEBUG
Xvoid	debug(), dprint();
X#endif	/* DEBUG */
X
X
X/* end of funcs.h */
!STUFFY!FUNK!
echo ""
echo "End of kit 5 (of 5)"
cat /dev/null >kit5isdone
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
