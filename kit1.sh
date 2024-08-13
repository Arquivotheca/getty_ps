#! /bin/sh

# Make a new directory for the getty sources, cd to it, and run kits 1
# thru 5 through sh.  When all 5 kits have been run, read README.

echo "This is getty 2.0 kit 1 (of 5).  If kit 1 is complete, the line"
echo '"'"End of kit 1 (of 5)"'" will echo at the end.'
echo ""
export PATH || (echo "You didn't use sh, you clunch." ; kill $$)
mkdir man 2>/dev/null
echo Extracting README
sed >README <<'!STUFFY!FUNK!' -e 's/X//'
X
X			   Getty Kit, Version 2.0
X
X		  Copyright (c) 1989,1990, Paul Sutcliffe Jr.
X
X-------------------------------------------------------------------------------
X
X	Permission is hereby granted to copy, reproduce, redistribute,
X	or otherwise use this software as long as: there is no monetary
X	profit gained specifically from the use or reproduction or this
X	software, it is not sold, rented, traded or otherwise marketed,
X	and this copyright notice is included prominently in any copy
X	made.
X
X	The author make no claims as to the fitness or correctness of
X	this software for any use whatsoever, and it is provided as is. 
X	Any use of this software is at the user's own risk.
X
X-------------------------------------------------------------------------------
X
X
XWHY THIS GETTY:
X
XAs most people have seen, the stock getty provided on Unix/Xenix
Xsystems lacks many features that can be useful.  The getty included in
Xthis distribution adds several features that I needed on my own system,
Xplus includes several "Wouldn't it be nice if ..." features I've heard
Xmentioned around UseNet.
X
XGetty 2.0 trys to emulate a "standard" System V getty in every way it
Xcan.  For instance, it uses the SysV /etc/gettydefs file (although you
Xmay give it a different name).  It also uses an /etc/issue file, if one
Xis present.
X
XAdded features include:
X
X    +	Can be used as a normal getty, or as "uugetty" to allow
X	bi-directional usage of modem lines.
X
X    +	Reads a "defaults" file at runtime, so that a single binary
X	can be configured differently on individual lines.  This also
X	allows you to change getty's behavior without recompiling.
X
X    +	Let's you specify default erase and kill characters, instead
X	of the ancient '#' and '@' convention still used in some
X	"modern" gettys.
X
X    +	Extensive debugging (to a log file) can be enabled at compile-
X	time.  The command line argument to envoke debugging is an
X	octal number -- the bit pattern determines which aspects of
X	getty's behavior are logged.
X
X    +	Let's you specify a program other than "login" to be executed
X	after the user name is entered.
X
X    +	(and the best for last:)  The line can be "initialized"
X	before sending the login banner (/etc/issue) and prompt with
X	the use of an expect/send sequence not unlike that used by the
X	UUCP L.sys (or Systems) file.
X
X    +	(and new in version 2.0:)  The CONNECT message from the modem
X	can be used to set the line speed; no more having to toggle
X	the speed by sending <break>'s or CR's.
X
X
XREQUIREMENTS:
X
XGetty 2.0 should drop right in to any AT&T (System III or V) Unix
Xor derivitive.  It has already been successfully installed on:
X
X	Tandy 6000		Tandy Xenix 3.2  (Microsoft Xenix 3.0)
X	NCR Tower 32/400	Unix SVR[23]
X	80386 clone		SCO Xenix V/386 2.2
X	Everex STEP 386is	ESIX SVR3.2 Rev C
X
X
XINSTALLATION:
X
XPlease read all the directions below before you proceed any further, and
Xthen follow them carefully.  Failure to do so may void your warranty. :-)
X
XAfter you have unpacked your kit(s), you should have all the files listed
Xin MANIFEST.
X
X1)  Run Configure.  This will figure out various things about your system.
X    Some things Configure will figure out for itself, other things it will
X    ask you about.  It will then proceed to make config.h, config.sh, and
X    Makefile.
X
X    You might possibly have to trim # comments from the front of Configure
X    if your sh doesn't handle them, but all other # comments will be taken
X    care of.
X
X2)  Glance through config.h to make sure system dependencies are correct.
X    Most of them should have been taken care of by running the Configure
X    script.
X
X    If you have any additional changes to make to the C definitions, they
X    can be done in the Makefile, or in config.h.  Bear in mind that they
X    will get undone next time you run Configure.
X
X3)  Copy the sample file tune.H to tune.h and edit tune.h to reflect the
X    special needs of your system and your desired features.  Use the
X    following as a guide:
X
X    boolean	If your compiler supports a (boolean) type, you may
X		remove this definition.
X
X    DEF_CFL	Define this to the <termio.h> parameters that will
X		identify your system's normal word length and parity.
X		Possible values are:
X
X			(CS8)			/* 8-bit, no parity */
X			(CS7|PARENB)		/* 7-bit, even parity */
X			(CS7|PARENB|PARODD)	/* 7-bit, odd parity */
X
X		Be sure to use only symbols defined in <termio.h> on
X		your system.
X
X    DEF_CONNECT	Define this to the default CONNECT string for your
X		modem(s).
X
X    DEBUG	Define this if you want the runtime debugging code
X		included in the executables.  See the section on
X		DEBUGGING in this readme for instructions in usage.
X
X    LOGUTMP	Define this if your utmp file (/etc/utmp) records
X		getty processes as a LOGIN_PROCESS.  This is true
X		for all SYS V sites that I'm aware of.
X
X    MY_CANON	Define this if you want to define your own ERASE and
X		KILL characters.  You may wish to do this if you are a
X		SYS V site whose defaults are the ancient '#' and '@'
X		characters.  See MY_ERASE and MY_KILL below.
X
X    RCSID	Define this if you want RCS version strings compiled
X		into the executables.  These can later be found with
X		the what (SCCS) or ident (RCS) commands.
X
X    SETTERM	Define this if you want getty to export the TERM
X		environment variable before calling login.  This will
X		only be done if getty knows what kind of terminal is
X		attached to the line it's running on.
X
X    TELEBIT	Define this if you will be using the autobauding
X		feature with Telebit modems.
X
X    TRYMAIL	Define this if you want getty to send email if it has
X		and error and cannot access the CONSOLE device.
X
X    WARNCASE	Define this to allow getty to warn a user if he/she has
X		used only upper-case letters in their login id.  If the
X		user re-enters his/her id a second time in upper-case,
X		that value is accepted and process accordingly.
X
X    MY_ERASE	If you've defined MY_CANON, use these to define the values
X    MY_KILL	you want for erase and kill characters.
X
X    TB_FAST	During autobauding, a Telebit will say CONNECT FAST
X		if a 9600 or 19200 PEP connection is made.  Define
X		this to the speed (either 9600 or 19200) you want
X		getty to set when it sees FAST.
X
X    NOTIFY	If you've defined TRYMAIL, use this to define the account
X		to which the email will be sent.
X
X    CONSOLE	Define this to the name of the console device.
X
X    DEFAULTS	Define this to the name of the defaults file.  The %s is
X		necessary, and will be replaced (via an sprintf()) by the
X		name of the executable--either getty or uugetty.
X
X    ISSUE	Define this to the name of your issue file.  If this
X		is undefined, no issue file will be displayed during
X		getty's startup.
X
X    LOGIN	Define this to the name of the login program to be called.
X
X    TRS16	Define this only if you're compiling getty on a Tandy 6000.
X		This define handles the different command line required due
X		to the V7 based /etc/init and also the dain-bramaged
X		/etc/inittab used on Tandy Xenix-68000 3.2
X
X    You may also wish to modify the values of {I,O,C,L}SANE in table.c,
X    as my idea of "Sane conditions" may differ from yours.
X
X4)  make depend
X
X    This will look for all the includes and modify Makefile accordingly.
X    Configure will offer to do this for you.
X
X5)  make lint
X
X    This step is optional, but highly recommended.
X
X6)  make
X
X    This will attempt to make getty and uugetty in the current directory.
X    It will also go to the man sub-directory and use m4 to create
X    nroff-able man pages.  It will then run nroff on the m4 output.
X
X7)  make install
X
X    This will put getty/uugetty into a public directory (normally /etc).
X    It will also make sure the man pages have been created.  It will not
X    install them.  You may need to be root to do this.  If you are not
X    root, you must own the directories in question and you should ignore
X    any messages about chown not working.
X
X    Also, if you don't already have an /etc/gettydefs file, you'll need
X    to create one.  This goes for the /etc/default files (if you are
X    using them) and the /etc/issue file.  There are examples of these
X    in the `sample.files' file.
X
X8)  Read the manual entries before running getty/uugetty.
X
X9)  IMPORTANT!  Help save the world!  Communicate any problems and suggested
X    patches to me, paul at devon.lns.pa.us (Paul Sutcliffe Jr.), so we can
X    keep the world in sync.  If you have a problem, there's someone else
X    out there who either has had or will have the same problem.
X
X    If possible, send in patches such that the patch program will apply them.
X    Context diffs are the best, then normal diffs.  Don't send ed scripts--
X    I've probably changed my copy since the version you have.
X
X    Watch for getty patches in comp.sources.bugs.  Patches will generally be
X    in a form usable by the patch program.  If you are just now bringing up
X    getty and aren't sure how many patches there are, write to me and I'll
X    send any you don't have.  Your current patch level is shown in patchlevel.h.
X
X
XDEBUGGING:
X
XTo use debugging, you must define DEBUG (in config.h) before compiling.
X
XTo envoke debugging, use the "-D onum" command line argument.  Onum is
Xan octal number.  To turn on all levels of debugging, use "-D 0377".
XTo pick specific areas to be watched, look at the defines in the "debug
Xlevels" section of getty.h.  The value for onum will be the result of
XOR-ing the values you want.  For instance, to debug the defaults file
Xand gettytab file processing, use "-D 022".
X
X
XHave fun.
X
X- paul
X
XINTERNET:  paul at devon.LNS.PA.US         |   How many whales do you have to
XUUCP:      ...!rutgers!devon!paul       |       save to get a toaster?
!STUFFY!FUNK!
echo Extracting man/README
sed >man/README <<'!STUFFY!FUNK!' -e 's/X//'
X
X			Getty 2.0 manual page files.
X
XThis README describes the files used and created by the Makefile.
X
XIn general, a file with a `.m4' extension is nroff source intersperced
Xwith m4 macros.  These files are processed by m4 to yield nroff-able
Xfiles, and use the macros to create man pages whose content matches the
Xway you've configured your getty/uugetty executables.  Running m4 on
Xthe .m4 files produce ready-for-nroff files with either a `.1m', `.3'
Xor `.4' extension, depending upon the chapter to which the man page
Xbelongs.  The makefile will also run nroff on these files, producing
Xfiles with a `.man' extension, by saying "make man".
X
XAfter running make in this directory, you will have the following files:
X
X	getty.1m	nroff-ready man page for getty
X	getty.man	nroff'd getty man page
X	gettytab.4 *	nroff-ready man page for the gettytab file
X	gettytab.man *	nroff'd gettytab man page
X	issue.4		nroff-ready man page for the issue file
X	issue.man	nroff'd issue man page
X
X* Note: the name `gettytab' will be replaced by the actual name you
X  assigned for that file -- usually `gettydefs'.
X
XAlso, you may have some (or all) of the following files, depending upon
Xthe configuration of your Unix/Xenix.  These files describe library
Xroutines used by getty that were not found in your libc.a (and thus
Xhomegrown versions were used):
X
X	getutent.3	nroff-ready man page for getutent(3)
X	getutent.man	nroff'd getutent man page
X	strdup.3	nroff-ready man page for strdup(3)
X	strdup.man	nroff'd strdup man page
X	putenv.3	nroff-ready man page for putenv(3)
X	putenv.man	nroff'd putenv man page
X
XYou will need to manually install the man pages.  Use either the .{1m,3,4}
X(pre-nroff) or .man (post-nroff) files, according to the needs of your
Xsystem.
X
X- paul
X
XINTERNET:  paul at devon.LNS.PA.US         |   How many whales do you have to
XUUCP:      ...!rutgers!devon!paul       |       save to get a toaster?
!STUFFY!FUNK!
echo Extracting main.c
sed >main.c <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: main.c,v 2.0 90/09/19 20:02:06 paul Rel $
X**
X**	Main body of program.
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
X**	$Log:	main.c,v $
X**	Revision 2.0  90/09/19  20:02:06  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X#define	MAIN
X
X#include "getty.h"
X#include "defaults.h"
X#include "table.h"
X#include <signal.h>
X#include <sys/stat.h>
X#include <errno.h>
X#ifdef	PWD
X#include <pwd.h>
X#endif	/* PWD */
X
X#if defined(RCSID) && !defined(lint)
Xstatic char *RcsId =
X"@(#)$Id: main.c,v 2.0 90/09/19 20:02:06 paul Rel $";
X#endif
X
X#if !defined(lint)
X#include "release.h"
Xstatic char *Release = RELEASE;
Xstatic char *RelDate = DATE;
X#endif
X
X/* how does this thing work
X */
X#define	USAGE	"Usage:\t%s [options] %s\n\t%s -c checkfile\n"
X#ifdef	TRS16
X#define	UOPT	"speed [defaultfile]"		/* Tandy Xenix/68k 3.2 */
X#else	/* TRS16 */
X#define	UOPT	"line [speed [type [lined]]]"	/* real System V */
X#endif	/* TRS16 */
X
X#define	VALUE(cptr)	((cptr == (char *) NULL) ? "NULL" : cptr)
X
Xstruct	speedtab {
X	ushort	cbaud;		/* baud rate */
X	int	nspeed;		/* speed in numeric format */
X	char	*speed;		/* speed in display format */
X} speedtab[] = {
X	{ B50,	  50,	 "50"	 },
X	{ B75,	  75,	 "75"	 },
X	{ B110,	  110,	 "110"	 },
X	{ B134,	  134,	 "134"	 },
X	{ B150,	  150,	 "150"	 },
X	{ B200,	  200,	 "200"	 },
X	{ B300,	  300,	 "300"	 },
X	{ B600,	  600,	 "600"	 },
X	{ B1200,  1200,	 "1200"	 },
X	{ B1800,  1800,	 "1800"	 },
X	{ B2400,  2400,	 "2400"	 },
X	{ B4800,  4800,	 "4800"	 },
X	{ B9600,  9600,	 "9600"	 },
X#ifdef	B19200
X	{ B19200, 19200, "19200" },
X#endif	/* B19200 */
X#ifdef	B38400
X	{ B38400, 38400, "38400" },
X#endif	/* B38400 */
X	{ EXTA,	  0,	 "EXTA"	 },
X	{ EXTB,	  0,	 "EXTB"	 },
X	{ 0,	  0,	 ""	 }
X};
X
Xextern	int	errno;
X
Xsig_t		timeout();
Xint		tputc();
Xvoid		exit_usage();
Xstruct	passwd	*getpwuid();
Xstruct	utmp	*getutent();
X#ifdef	DEBUG
Xchar		*ctime();
X#endif	/* DEBUG */
X
X
X#ifdef	UUGETTY
X
Xchar	*lock, *altlock;
X
Xint	makelock(), readlock();
Xboolean	checklock();
Xsig_t	rmlocks();
X
X#endif	/* UUGETTY */
X
X
X#ifdef	WARNCASE
Xchar	*bad_case[] = {
X	"\r\n",
X	"If your terminal supports lower case letters, please\r\n",
X	"use them.  Login again, using lower case if possible.\r\n",
X	(char *) NULL
X};
X#endif	/* WARNCASE */
X
X
Xmain(argc, argv)
Xint argc;
Xchar *argv[];
X{
X	register int c, i, fd;
X	int cbaud, nspeed, flags;
X	char ch, *p, *speed, devname[MAXLINE+1];
X	STDCHAR buf[MAXLINE+1];
X	char termcap[1024], tbuf[64];
X	char *tgetstr();
X	DEF **def;
X	TERMIO termio;
X	GTAB *gtab, *gt;
X	FILE *fp;
X	struct utmp *utmp;
X	struct stat st;
X
X#if defined(DEBUG) || defined(LOGUTMP)
X	time_t clock;
X#endif	/* DEBUG || LOGUTMP */
X
X#ifndef	TRS16
X	char lined[MAXLINE+1];
X#endif	/* TRS16 */
X
X#ifdef	UUGETTY
X	struct passwd *pwd;
X	UIDTYPE uucpuid = 0;
X	GIDTYPE uucpgid = 0;
X#endif	/* UUGETTY */
X
X#ifdef	TTYTYPE
X	char name[16], line[16];
X#endif	/* TTYTYPE */
X
X#ifdef	LOGUTMP
X	int pid;
X#endif	/* LOGUTMP */
X
X#ifdef	ISSUE
X	char *issue = ISSUE;			/* default issue file */
X#endif	/* ISSUE */
X
X	boolean clear = TRUE;			/* clear screen flag */
X	char *login = LOGIN;			/* default login program */
X	char *clrscr = (char *) NULL;		/* string to clear screen */
X	char *defname = (char *) NULL;		/* defaults file name */
X	char *init = (char *) NULL;		/* value of INIT */
X	char term[16];				/* terminal type */
X	boolean waitchar = FALSE;		/* wait for char flag */
X	unsigned int delay = 0;			/* #sec's delay before prompt */
X	char *waitfor = (char *) NULL;		/* string to wait for */
X	char *connect = (char *) NULL;		/* connect chat string */
X
X	extern int optind;
X	extern char *optarg;
X	extern int expect();
X
X	/* startup
X	 */
X	(void) signal(SIGINT, SIG_IGN);
X	(void) signal(SIGQUIT, SIG_DFL);
X	(void) signal(SIGTERM, SIG_DFL);
X
X	(void) strcpy(term, "unknown");
X	AutoBaud = FALSE;
X	AutoRate[0] = '\0';
X	Check = FALSE;
X	CheckFile = (char *) NULL;
X#ifdef	DEBUG
X	Debug = 0;
X#endif	/* DEBUG */
X	Device = "unknown";
X	GtabId = (char *) NULL;
X	LineD = (char *) NULL;
X	NoHangUp = FALSE;
X	TimeOut = 0;
X#ifdef	WARNCASE
X	WarnCase = TRUE;
X#endif	/* WARNCASE */
X
X	/* who am I?
X	 */
X#ifdef	UUGETTY
X	MyName = "uugetty";
X#else
X	MyName = "getty";
X#endif	/* UUGETTY */
X
X	/* process the command line
X	 */
X
X	while ((c = getopt(argc, argv, "C:D:c:d:ht:w:")) != EOF) {
X		switch (c) {
X		case 'C':
X			connect = optarg;
X			break;
X		case 'D':
X#ifdef	DEBUG
X			(void) sscanf(optarg, "%o", &Debug);
X			Dfp = stderr;
X#else	/* DEBUG */
X			logerr("DEBUG not compiled in");
X#endif	/* DEBUG */
X			break;
X		case 'c':
X			Check = TRUE;
X			CheckFile = optarg;
X			break;
X		case 'd':
X			defname = optarg;
X			break;
X		case 'h':
X			NoHangUp = TRUE;
X			break;
X		case 'r':
X			waitchar = TRUE;
X			delay = (unsigned) atoi(optarg);
X			break;
X		case 't':
X			TimeOut = atoi(optarg);
X			break;
X		case 'w':
X			waitchar = TRUE;
X			waitfor = optarg;
X			break;
X		case '?':
X			exit_usage(2);
X		}
X	}
X
X	/* just checking?
X	 */
X	if (Check) {
X		(void) signal(SIGINT, SIG_DFL);
X		(void) gtabvalue((char *) NULL, G_CHECK);
X		exit(0);
X	}
X
X#ifdef	TRS16
X	
X	/* special handling for v7-based init
X	 */
X
X	if (optind < argc)
X		GtabId = argv[optind++];
X	else {
X		logerr("no speed given");
X		exit_usage(2);
X	}
X
X	/* Tandy Xenix/68k 3.2 /etc/inittab allows one optional argument
X	 * after the speed flag.  The best use I could do with it here is
X	 * to assume that it's the name of the defaults file to be used.
X	 *
X	 * Sigh.  Actually, it's not optional -- if none is given in
X	 * /etc/inittab, then it appears here as a 0-length string.
X	 */
X	if (optind < argc)
X		if (strlen(argv[optind]) > 0)
X			defname = argv[optind++];
X
X	if ((p = ttyname(STDIN)) != (char *) NULL)
X		Device = p+5;		/* strip off "/dev/" */
X	else {
X		logerr("cannot determine line");
X		exit_usage(2);
X	}
X
X#else	/* TRS16 */
X
X	/* normal System V handling
X	 */
X
X	if (optind < argc)
X		Device = argv[optind++];
X	else {
X		logerr("no line given");
X		exit_usage(2);
X	}
X	if (optind < argc)
X		GtabId = argv[optind++];
X	if (optind < argc)
X		(void) strncpy(term, argv[optind++], sizeof(term));
X	if (optind < argc) {
X		(void) strncpy(lined, argv[optind++], sizeof(lined));
X		LineD = lined;
X	}
X
X#endif	/* TRS16 */
X
X#ifdef	TTYTYPE
X
X	if (strequal(term, "unknown")) {
X		if ((fp = fopen(TTYTYPE, "r")) == (FILE *) NULL) {
X			(void) sprintf(MsgBuf, "cannot open %s", TTYTYPE);
X			logerr(MsgBuf);
X		} else {
X			while ((fscanf(fp, "%s %s", name, line)) != EOF) {
X				if (strequal(line, Device)) {
X					(void) strncpy(term,name,sizeof(term));
X					break;
X				}
X			}
X			(void) fclose(fp);
X		}
X	}
X
X#endif	/* TTYTYPE */
X
X	/* need full name of the device
X	 */
X	(void) sprintf(devname, "/dev/%s", Device);
X
X	/* command line parsed, now build the list of
X	 * runtime defaults; this may override things set above.
X	 */
X	def = defbuild(defname);
X
X#ifdef	DEBUG
X
X	/* debugging on?
X	 */
X	if ((p = defvalue(def, "DEBUG")) != (char *) NULL)
X		(void) sscanf(p, "%o", &Debug);
X
X	if (Debug) {
X		(void) sprintf(buf, "/tmp/getty:%s", Device);
X		if ((Dfp = fopen(buf, "a+")) == (FILE *) NULL) {
X			logerr("cannot open debug file");
X			exit(FAIL);
X		} else {
X			if (fileno(Dfp) < 3) {
X				if ((fd = fcntl(fileno(Dfp), F_DUPFD, 3)) > 2) {
X					(void) fclose(Dfp);
X					Dfp = fdopen(fd, "a+");
X				}
X			}
X			(void) time(&clock);
X			(void) fprintf(Dfp, "%s Started: %s",
X					MyName, ctime(&clock));
X		}
X	}
X
X	debug(D_OPT, "command line values:\n");
X	debug(D_OPT, " [-C] connect  = (%s)\n", VALUE(connect));
X	debug(D_OPT, " [-d] defname  = (%s)\n", VALUE(defname));
X	debug(D_OPT, " [-h] NoHangUp = (%s)\n", (NoHangUp) ? "TRUE" : "FALSE");
X	debug(D_OPT, " [-r] waitchar = (%s)\n", (waitchar) ? "TRUE" : "FALSE");
X	debug(D_OPT, "      delay    = (%u)\n", delay);
X	debug(D_OPT, " [-t] TimeOut  = (%d)\n", TimeOut);
X	debug(D_OPT, " [-w] waitfor  = (%s)\n", VALUE(waitfor));
X	debug(D_OPT, " line  = (%s)\n", VALUE(Device));
X	debug(D_OPT, " speed = (%s)\n", VALUE(GtabId));
X	debug(D_OPT, " type  = (%s)\n", term);
X	debug(D_OPT, " lined = (%s)\n", VALUE(LineD));
X	debug(D_RUN, "loading defaults\n");
X
X#endif	/* DEBUG */
X
X	/* setup all runtime values
X	 */
X
X	if ((SysName = defvalue(def, "SYSTEM")) == (char *) NULL)
X		SysName = getuname();
X
X	if ((Version = defvalue(def, "VERSION")) != (char *) NULL)
X		if (*Version == '/') {
X			if ((fp = fopen(Version, "r")) != (FILE *) NULL) {
X				(void) fgets(buf, sizeof(buf), fp);
X				(void) fclose(fp);
X				buf[strlen(buf)-1] = '\0';
X				Version = strdup(buf);
X			}
X		}
X
X	if ((p = defvalue(def, "LOGIN")) != (char *) NULL)
X		login = p;
X	if ((p = defvalue(def, "INIT")) != (char *) NULL)
X		init = p;
X#ifdef	ISSUE
X	if ((p = defvalue(def, "ISSUE")) != (char *) NULL)
X		issue = p;
X#endif	/* ISSUE */
X	if ((p = defvalue(def, "CLEAR")) != (char *) NULL)
X		if (strequal(p, "NO"))
X			clear = FALSE;
X	if ((p = defvalue(def, "HANGUP")) != (char *) NULL)
X		if (strequal(p, "NO"))
X			NoHangUp = TRUE;
X	if ((p = defvalue(def, "WAITCHAR")) != (char *) NULL)
X		if (strequal(p, "YES"))
X			waitchar = TRUE;
X	if ((p = defvalue(def, "DELAY")) != (char *) NULL)
X		delay = (unsigned) atoi(p);
X	if ((p = defvalue(def, "TIMEOUT")) != (char *) NULL)
X		TimeOut = atoi(p);
X	if ((p = defvalue(def, "CONNECT")) != (char *) NULL)
X		connect = p;
X	if ((p = defvalue(def, "WAITFOR")) != (char *) NULL) {
X		waitchar = TRUE;
X		waitfor = p;
X	}
X
X	/* find out how to clear the screen
X	 */
X	if (!strequal(term, "unknown")) {
X		p = tbuf;
X		if ((tgetent(termcap, term)) == 1)
X			if ((clrscr = tgetstr("cl", &p)) == (char *) NULL)
X				clrscr = "";
X	}
X
X#ifdef	UUGETTY
X
X	debug2(D_RUN, "check for lockfiles\n");
X
X	/* deal with the lockfiles; we don't want to charge
X	 * ahead if uucp, kermit or something is already
X	 * using the line.
X	 */
X
X	/* name the lock file(s)
X	 */
X	(void) sprintf(buf, LOCK, Device);
X	lock = strdup(buf);
X	altlock = defvalue(def, "ALTLOCK");
X	if (altlock != (char *) NULL) {
X		(void) sprintf(buf, LOCK, altlock);
X		altlock = strdup(buf);
X	}
X	debug3(D_LOCK, "lock = (%s)\n", lock);
X	debug3(D_LOCK, "altlock = (%s)\n", VALUE(altlock));
X
X	/* check for existing lock file(s)
X	 */
X	if (checklock(lock) == TRUE) {
X		while (checklock(lock) == TRUE)
X			(void) sleep(60);
X		exit(0);
X	}
X
X	/* there's a race condition just asking for trouble here  :-(
X	 */
X	if (altlock != (char *) NULL && checklock(altlock) == TRUE) {
X		while (checklock(altlock) == TRUE)
X			(void) sleep(60);
X		exit(0);
X	}
X
X	/* allow uucp to access the device
X	 */
X	(void) chmod(devname, 0666);
X	if ((pwd = getpwuid(UUCPID)) != (struct passwd *) NULL) {
X		uucpuid = pwd->pw_uid;
X		uucpgid = pwd->pw_gid;
X	}
X	(void) chown(devname, uucpuid, uucpgid);
X
X#else	/* UUGETTY */
X
X	(void) chmod(devname, 0622);
X	if (stat(devname, &st) == 0)
X		(void) chown(devname, 0, st.st_gid);
X	else
X		(void) chown(devname, 0, 0);
X
X#endif	/* UUGETTY */
X
X	/* the line is mine now ...
X	 */
X
X	debug2(D_RUN, "open stdin, stdout and stderr\n");
X
X	/* open the device; don't wait around for carrier-detect
X	 */
X	if ((fd = open(devname, O_RDWR | O_NDELAY)) < 0) {
X		logerr("cannot open line");
X		exit(FAIL);
X	}
X
X	/* make new fd == stdin if it isn't already
X	 */
X	if (fd > 0) {
X		(void) close(0);
X		if (dup(fd) != 0) {
X			logerr("cannot open stdin");
X			exit(FAIL);
X		}
X	}
X
X	/* make stdout and stderr, too
X	 */
X	(void) close(1);
X	(void) close(2);
X	if (dup(0) != 1) {
X		logerr("cannot open stdout");
X		exit(FAIL);
X	}
X	if (dup(0) != 2) {
X		logerr("cannot open stderr");
X		exit(FAIL);
X	}
X
X	if (fd > 0)
X		(void) close(fd);
X
X	/* no buffering
X	 */
X	setbuf(stdin, (char *) NULL);
X	setbuf(stdout, (char *) NULL);
X	setbuf(stderr, (char *) NULL);
X
X	debug2(D_RUN, "setup terminal\n");
X
X	/* get the required info from the gettytab file
X	 */
X	gtab = gtabvalue(GtabId, G_FORCE);
X
X	/* setup terminal
X	 */
X	if (!NoHangUp) {
X		(void) ioctl(STDIN, TCGETA, &termio);
X		termio.c_cflag &= ~CBAUD;	/* keep all but CBAUD bits */
X		termio.c_cflag |= B0;		/* set speed == 0 */
X		(void) ioctl(STDIN, TCSETAF, &termio);
X	}
X	settermio(&(gtab->itermio), INITIAL);
X
X	/* clear O_NDELAY flag now
X	 */
X	flags = fcntl(STDIN, F_GETFL, 0);
X	(void) fcntl(STDIN, F_SETFL, flags & ~O_NDELAY);
X
X	/* handle init sequence if requested
X	 */
X	if (init != (char *) NULL) {
X		debug2(D_RUN, "perform line initialization\n");
X		if (chat(init) == FAIL)
X			logerr("warning: INIT sequence failed");
X	}
X
X	/* do we need to wait ?
X	 */
X	if (waitchar) {
X
X		debug2(D_RUN, "waiting for any char ...\n");
X
X		(void) ioctl(STDIN, TCFLSH, 0);
X		(void) read(STDIN, &ch, 1);		/* this will block */
X
X		debug2(D_RUN, "... got one!\n");
X
X#ifdef	UUGETTY
X		/* check to see if line is locked, we don't want to
X		 * read more chars if that's the case
X		 */
X		if (checklock(lock) == TRUE) {
X			debug2(D_RUN, "line locked now, stopping\n");
X			while (checklock(lock) == TRUE)
X				(void) sleep(60);
X			exit(0);
X		}
X		if (altlock != (char *) NULL && checklock(altlock) == TRUE) {
X			debug2(D_RUN, "line locked now, stopping\n");
X			while (checklock(altlock) == TRUE)
X				(void) sleep(60);
X			exit(0);
X		}
X#endif	/* UUGETTY */
X
X		if (waitfor != (char *) NULL) {
X			if (ch == *waitfor) {	/* first char equal ? */
X				debug3(D_RUN, "matched waitfor[0] (%c)\n", ch);
X				if (!(*waitfor)) {
X					debug2(D_RUN, "match complete\n");
X					goto wait_cont;
X				}
X				waitfor++;
X			}
X			if (expect(waitfor) == FAIL)
X				exit(0);
X		}
X
X	    wait_cont:
X		if (delay) {
X			debug3(D_RUN, "delay(%d)\n", delay);
X			(void) sleep(delay);
X			/* eat up any garbage from the line (modem) */
X			(void) fcntl(STDIN, F_SETFL, flags | O_NDELAY);
X			while (read(STDIN, &ch, 1) == 1)
X				;
X			(void) fcntl(STDIN, F_SETFL, flags & ~O_NDELAY);
X		}
X
X	}
X
X#ifdef	UUGETTY
X
X	debug2(D_RUN, "locking the line\n");
X
X	/* try to lock the line
X	 */
X	if (makelock(lock) == FAIL) {
X		while (checklock(lock) == TRUE)
X			(void) sleep(60);
X		exit(0);
X	}
X	if (altlock != (char *) NULL && makelock(altlock) == FAIL) {
X		while (checklock(altlock) == TRUE)
X			(void) sleep(60);
X		exit(0);
X	}
X
X	/* set to remove lockfile(s) on certain signals
X	 */
X	(void) signal(SIGHUP, rmlocks);
X	(void) signal(SIGINT, rmlocks);
X	(void) signal(SIGQUIT, rmlocks);
X	(void) signal(SIGTERM, rmlocks);
X
X#endif	/* UUGETTY */
X
X#ifdef	LOGUTMP
X
X	debug2(D_RUN, "update utmp/wtmp files\n");
X
X	pid = getpid();
X	while ((utmp = getutent()) != (struct utmp *) NULL) {
X		if (utmp->ut_type == INIT_PROCESS && utmp->ut_pid == pid) {
X
X			debug2(D_UTMP, "logutmp entry made\n");
X			/* show login process in utmp
X			 */
X			strncopy(utmp->ut_line, Device);
X			strncopy(utmp->ut_user, "LOGIN");
X			utmp->ut_pid = pid;
X			utmp->ut_type = LOGIN_PROCESS;
X			(void) time(&clock);
X			utmp->ut_time = clock;
X			pututline(utmp);
X
X			/* write same record to end of wtmp
X			 * if wtmp file exists
X			 */
X			if (stat(WTMP_FILE, &st) && errno == ENOENT)
X				break;
X			if ((fp = fopen(WTMP_FILE, "a")) != (FILE *) NULL) {
X				(void) fseek(fp, 0L, 2);
X				(void) fwrite((char *)utmp,sizeof(*utmp),1,fp);
X				(void) fclose(fp);
X			}
X		}
X	}
X	endutent();
X
X#endif	/* LOGUTMP */
X
X	if (connect != (char *) NULL) {
X
X		debug2(D_RUN, "perform connect sequence\n");
X
X		cbaud = 0;
X		if (strequal(connect, "DEFAULT"))
X			connect = DEF_CONNECT;
X		if (chat(connect) == FAIL)
X			logerr("warning: CONNECT sequence failed");
X		if (AutoBaud) {
X			debug3(D_RUN, "AutoRate = (%s)\n", AutoRate);
X#ifdef	TELEBIT
X			if (strequal(AutoRate, "FAST"))
X				(void) strcpy(AutoRate, TB_FAST);
X#endif	/* TELEBIT */
X			if ((nspeed = atoi(AutoRate)) > 0)
X				for (i=0; speedtab[i].nspeed; i++)
X					if (nspeed == speedtab[i].nspeed) {
X						cbaud = speedtab[i].cbaud;
X						speed = speedtab[i].speed;
X						break;
X					}
X		}
X		if (cbaud) {	/* AutoBaud && match found */
X			debug3(D_RUN, "setting speed to %s\n", speed);
X			if ((gt = gtabvalue(speed, G_FIND)) != (GTAB *) NULL) {
X				/* use matching line from gettytab */
X				if (strequal(gt->cur_id, speed)) {
X					gtab = gt;
X					goto set_term;
X				}
X			}
X			/* change speed of existing gettytab line
X			 */
X			gtab->itermio.c_cflag =
X				(gtab->itermio.c_cflag & ~CBAUD) | cbaud;
X			gtab->ftermio.c_cflag =
X				(gtab->ftermio.c_cflag & ~CBAUD) | cbaud;
X		    set_term:
X			settermio(&(gtab->itermio), INITIAL);
X		}
X	}
X
X	debug2(D_RUN, "entering login loop\n");
X
X	/* loop until a successful login is made
X	 */
X	for (;;) {
X
X		/* set Nusers value
X		 */
X		Nusers = 0;
X		setutent();
X		while ((utmp = getutent()) != (struct utmp *) NULL) {
X#ifdef	USER_PROCESS
X			if (utmp->ut_type == USER_PROCESS)
X#endif	/* USER_PROCESS */
X			{
X				Nusers++;
X				debug3(D_UTMP, "utmp entry (%s)\n",
X						utmp->ut_name);
X			}
X		}
X		endutent();
X		debug3(D_UTMP, "Nusers=%d\n", Nusers);
X
X		/* set Speed value
X		 */
X		cbaud = gtab->itermio.c_cflag & CBAUD;
X		for (i=0; speedtab[i].cbaud != cbaud; i++)
X			;
X		Speed = speedtab[i].speed;
X
X#ifdef	ISSUE
X		if (clear && *clrscr)		/* clear screen */
X			(void) tputs(clrscr, 1, tputc);
X
X		(void) fputc('\r', stdout);	/* just in case */
X
X		if (def == (DEF **) NULL)	/* no defaults file */
X			(void) Fputs("@S\n", stdout);
X
X		/* display ISSUE, if present
X		 */
X		if (*issue != '/') {
X			(void) Fputs(issue, stdout);
X			(void) fputs("\r\n", stdout);
X		} else if ((fp = fopen(issue, "r")) != (FILE *) NULL) {
X			while (fgets(buf, sizeof(buf), fp) != (char *) NULL)
X				(void) Fputs(buf, stdout);
X			(void) fclose(fp);
X		}
X#endif	/* ISSUE */
X
X	    login_prompt:
X
X		/* display login prompt
X		 */
X		(void) Fputs(gtab->login, stdout);
X
X		/* eat any chars from line noise
X		 */
X		(void) ioctl(STDIN, TCFLSH, 0);
X
X		/* start timer, if required
X		 */
X		if (TimeOut > 0) {
X			(void) signal(SIGALRM, timeout);
X			(void) alarm((unsigned) TimeOut);
X		}
X
X		/* handle the login name
X		 */
X		switch (getlogname(&termio, buf, MAXLINE)) {
X		case SUCCESS:
X			/* stop alarm clock
X			 */
X			if (TimeOut > 0)
X				(void) alarm((unsigned) 0);
X
X			/* setup terminal
X			 */
X			termio.c_iflag |= gtab->ftermio.c_iflag;
X			termio.c_oflag |= gtab->ftermio.c_oflag;
X			termio.c_cflag |= gtab->ftermio.c_cflag;
X			termio.c_lflag |= gtab->ftermio.c_lflag;
X			termio.c_line  |= gtab->ftermio.c_line;
X			settermio(&termio, FINAL);
X#ifdef	DEBUG
X			if (Debug)
X				(void) fclose(Dfp);
X#endif	/* DEBUG */
X
X#ifdef	SETTERM
X			(void) sprintf(MsgBuf, "TERM=%s", term);
X			(void) putenv(strdup(MsgBuf));
X#endif	/* SETTERM */
X
X			/* hand off to login, which can be a shell script!
X			 */
X			(void) execl(login, "login", buf, (char *) NULL);
X			(void) execl("/bin/sh", "sh", "-c",
X					login, buf, (char *) NULL);
X			(void) sprintf(MsgBuf, "cannot execute %s", login);
X			logerr(MsgBuf);
X			exit(FAIL);
X
X		case BADSPEED:
X			/* go to next entry
X			 */
X			GtabId = gtab->next_id;
X			debug3(D_RUN, "Bad Speed; trying %s\n", GtabId);
X			gtab = gtabvalue(GtabId, G_FORCE);
X			settermio(&(gtab->itermio), INITIAL);
X			break;
X
X#ifdef	WARNCASE
X		case BADCASE:
X			/* first try was all uppercase
X			 */
X			for (i=0; bad_case[i] != (char *) NULL; i++)
X				(void) fputs(bad_case[i], stdout);
X			goto login_prompt;
X#endif	/* WARNCASE */
X
X		case NONAME:
X			/* no login name entered
X			 */
X			break;
X		}
X	}
X}
X
X
X/*
X**	timeout() - handles SIGALRM
X*/
X
Xsig_t
Xtimeout()
X{
X	TERMIO termio;
X
X	/* say bye-bye
X	 */
X	(void) sprintf(MsgBuf, "\nTimed out after %d seconds.\n", TimeOut);
X	(void) Fputs(MsgBuf, stdout);
X	(void) Fputs("Bye Bye.\n", stdout);
X
X	/* force a hangup
X	 */
X	(void) ioctl(STDIN, TCGETA, &termio);
X	termio.c_cflag &= ~CBAUD;
X	termio.c_cflag |= B0;
X	(void) ioctl(STDIN, TCSETAF, &termio);
X
X	exit(1);
X}
X
X
X/*
X**	tputc() - output a character for tputs()
X*/
X
Xint
Xtputc(c)
Xchar c;
X{
X	fputc(c, stdout);
X}
X
X
X/*
X**	exit_usage() - exit with usage display
X*/
X
Xvoid
Xexit_usage(code)
Xint code;
X{
X	FILE *fp;
X
X	if ((fp = fopen(CONSOLE, "w")) != (FILE *) NULL) {
X		(void) fprintf(fp, USAGE, MyName, UOPT, MyName);
X		(void) fclose(fp);
X	}
X	exit(code);
X}
X
X
X#ifdef	UUGETTY
X
X/*
X**	makelock() - attempt to create a lockfile
X**
X**	Returns FAIL if lock could not be made (line in use).
X*/
X
Xint
Xmakelock(name)
Xchar *name;
X{
X	int fd, pid;
X	char *temp, buf[MAXLINE+1];
X#ifdef	ASCIIPID
X	char apid[16];
X#endif	/* ASCIIPID */
X	int getpid();
X	char *mktemp();
X
X	debug3(D_LOCK, "makelock(%s) called\n", name);
X
X	/* first make a temp file
X	 */
X	(void) sprintf(buf, LOCK, "TM.XXXXXX");
X	if ((fd = creat((temp=mktemp(buf)), 0444)) == FAIL) {
X		(void) sprintf(MsgBuf, "cannot create tempfile (%s)", temp);
X		logerr(MsgBuf);
X		return(FAIL);
X	}
X	debug3(D_LOCK, "temp = (%s)\n", temp);
X
X	/* put my pid in it
X	 */
X#ifdef	ASCIIPID
X	(void) sprintf(apid, "%09d", getpid());
X	(void) write(fd, apid, strlen(apid));
X#else
X	pid = getpid();
X	(void) write(fd, (char *)&pid, sizeof(pid));
X#endif	/* ASCIIPID */
X	(void) close(fd);
X
X	/* link it to the lock file
X	 */
X	while (link(temp, name) == FAIL) {
X		debug3(D_LOCK, "link(temp,name) failed, errno=%d\n", errno);
X		if (errno == EEXIST) {		/* lock file already there */
X			if ((pid = readlock(name)) == FAIL)
X				continue;
X			if ((kill(pid, 0) == FAIL) && errno == ESRCH) {
X				/* pid that created lockfile is gone */
X				(void) unlink(name);
X				continue;
X			}
X		}
X		debug2(D_LOCK, "lock NOT made\n");
X		(void) unlink(temp);
X		return(FAIL);
X	}
X	debug2(D_LOCK, "lock made\n");
X	(void) unlink(temp);
X	return(SUCCESS);
X}
X
X/*
X**	checklock() - test for presense of valid lock file
X**
X**	Returns TRUE if lockfile found, FALSE if not.
X*/
X
Xboolean
Xchecklock(name)
Xchar *name;
X{
X	int pid;
X	struct stat st;
X
X	debug3(D_LOCK, "checklock(%s) called\n", name);
X
X	if ((stat(name, &st) == FAIL) && errno == ENOENT) {
X		debug2(D_LOCK, "stat failed, no file\n");
X		return(FALSE);
X	}
X
X	if ((pid = readlock(name)) == FAIL) {
X		debug2(D_LOCK, "couldn't read lockfile\n");
X		return(FALSE);
X	}
X
X	if ((kill(pid, 0) == FAIL) && errno == ESRCH) {
X		debug2(D_LOCK, "no active process has lock, will remove\n");
X		(void) unlink(name);
X		return(FALSE);
X	}
X
X	debug2(D_LOCK, "active process has lock, return(TRUE)\n");
X	return(TRUE);
X}
X
X/*
X**	readlock() - read contents of lockfile
X**
X**	Returns pid read or FAIL on error.
X*/
X
Xint
Xreadlock(name)
Xchar *name;
X{
X	int fd, pid;
X#ifdef	ASCIIPID
X	char apid[16];
X#endif	/* ASCIIPID */
X
X	if ((fd = open(name, O_RDONLY)) == FAIL)
X		return(FAIL);
X
X#ifdef	ASCIIPID
X	(void) read(fd, apid, sizeof(apid));
X	(void) sscanf(apid, "%d", &pid);
X#else
X	(void) read(fd, (char *)&pid, sizeof(pid));
X#endif	/* ASCIIPID */
X
X	(void) close(fd);
X	return(pid);
X}
X
X/*
X**	rmlocks() - remove lockfile(s)
X*/
X
Xsig_t
Xrmlocks()
X{
X	if (altlock != (char *) NULL)
X		(void) unlink(altlock);
X
X	(void) unlink(lock);
X}
X
X#endif	/* UUGETTY */
X
X
X/* end of main.c */
!STUFFY!FUNK!
echo Extracting table.c
sed >table.c <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: table.c,v 2.0 90/09/19 20:18:46 paul Rel $
X**
X**	Routines to process the gettytab file.
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
X**	$Log:	table.c,v $
X**	Revision 2.0  90/09/19  20:18:46  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X#include "getty.h"
X#include "table.h"
X
X#if defined(RCSID) && !defined(lint)
Xstatic char *RcsId =
X"@(#)$Id: table.c,v 2.0 90/09/19 20:18:46 paul Rel $";
X#endif
X
X
X/*	Sane conditions.
X */
X#define	ISANE	( BRKINT | IGNPAR | ISTRIP | ICRNL | IXON | IXANY )
X#define	OSANE	( OPOST | ONLCR )
X#define	CSANE	( DEF_CFL | CREAD | HUPCL )
X#define	LSANE	( ISIG | ICANON | ECHO | ECHOE | ECHOK )
X
X#define	CC_SANE	{ CINTR, CQUIT, CERASE, CKILL, CEOF, CNUL, CNUL, CNUL }
X
X
X/*	States for gtabvalue()
X */
X#define	ENTRY	0	/* looking for an entry line */
X#define	QUIT	1	/* error occurred */
X
X
X#define	NULLPTR		(char *) NULL
X
X
X/*	All possible mode flags.
X */
X
XSYMTAB	imodes[] = {
X	{ "IGNBRK",	IGNBRK	},
X	{ "BRKINT",	BRKINT	},
X	{ "IGNPAR",	IGNPAR	},
X	{ "PARMRK",	PARMRK	},
X	{ "INPCK",	INPCK	},
X	{ "ISTRIP",	ISTRIP	},
X	{ "INLCR",	INLCR	},
X	{ "IGNCR",	IGNCR	},
X	{ "ICRNL",	ICRNL	},
X	{ "IUCLC",	IUCLC	},
X	{ "IXON",	IXON	},
X	{ "IXANY",	IXANY	},
X	{ "IXOFF",	IXOFF	},
X	{  NULLPTR,	0	}
X};
X
XSYMTAB	omodes[] = {
X	{ "OPOST",	OPOST	},
X	{ "OLCUC",	OLCUC	},
X	{ "ONLCR",	ONLCR	},
X	{ "OCRNL",	OCRNL	},
X	{ "ONOCR",	ONOCR	},
X	{ "ONLRET",	ONLRET	},
X	{ "OFILL",	OFILL	},
X	{ "OFDEL",	OFDEL	},
X	{ "NLDLY",	NLDLY	},
X	{ "NL0",	NL0	},
X	{ "NL1",	NL1	},
X	{ "CRDLY",	CRDLY	},
X	{ "CR0",	CR0	},
X	{ "CR1",	CR1	},
X	{ "CR2",	CR2	},
X	{ "CR3",	CR3	},
X	{ "TABDLY",	TABDLY	},
X	{ "TAB0",	TAB0	},
X	{ "TAB1",	TAB1	},
X	{ "TAB2",	TAB2	},
X	{ "TAB3",	TAB3	},
X	{ "BSDLY",	BSDLY	},
X	{ "BS0",	BS0	},
X	{ "BS1",	BS1	},
X	{ "VTDLY",	VTDLY	},
X	{ "VT0",	VT0	},
X	{ "VT1",	VT1	},
X	{ "FFDLY",	FFDLY	},
X	{ "FF0",	FF0	},
X	{ "FF1",	FF1	},
X	{  NULLPTR,	0	}
X};
X
XSYMTAB	cmodes[] = {
X	{ "B0",		B0	},
X	{ "B50",	B50	},
X	{ "B75",	B75	},
X	{ "B110",	B110	},
X	{ "B134",	B134	},
X	{ "B150",	B150	},
X	{ "B200",	B200	},
X	{ "B300",	B300	},
X	{ "B600",	B600	},
X	{ "B1200",	B1200	},
X	{ "B1800",	B1800	},
X	{ "B2400",	B2400	},
X	{ "B4800",	B4800	},
X	{ "B9600",	B9600	},
X#ifdef	B19200
X	{ "B19200",	B19200	},
X#endif	/* B19200 */
X#ifdef	B38400
X	{ "B38400",	B38400	},
X#endif	/* B38400 */
X	{ "EXTA",	EXTA	},
X	{ "EXTB",	EXTB	},
X	{ "CS5",	CS5	},
X	{ "CS6",	CS6	},
X	{ "CS7",	CS7	},
X	{ "CS8",	CS8	},
X	{ "CSTOPB",	CSTOPB	},
X	{ "CREAD",	CREAD	},
X	{ "PARENB",	PARENB	},
X	{ "PARODD",	PARODD	},
X	{ "HUPCL",	HUPCL	},
X	{ "CLOCAL",	CLOCAL	},
X#ifdef	LOBLK
X	{ "LOBLK",	LOBLK	},
X#endif	/* LOBLK */
X	{  NULLPTR,	0	},
X};
X
XSYMTAB	lmodes[] = {
X	{ "ISIG",	ISIG	},
X	{ "ICANON",	ICANON	},
X	{ "XCASE",	XCASE	},
X	{ "ECHO",	ECHO	},
X	{ "ECHOE",	ECHOE	},
X	{ "ECHOK",	ECHOK	},
X	{ "ECHONL",	ECHONL	},
X	{ "NOFLSH",	NOFLSH	},
X#ifdef	XCLUDE
X	{ "XCLUDE",	XCLUDE	},
X#endif	/* XCLUDE */
X	{  NULLPTR,	0	}
X};
X
XSYMTAB	ldiscs[] = {
X	{ "LDISC0",	LDISC0	},
X	{  NULLPTR,	0	}
X};
X
X/*
X *	Gettytab entry to use if no other can be determined
X */
XGTAB	Default = {
X	"default",
X	{ 0, 0, ( SSPEED | CSANE ), 0, 0, CC_SANE, },
X	{ ISANE, OSANE, ( SSPEED | CSANE ), LSANE, LDISC0, CC_SANE, },
X	"login: ",
X	"default"
X};
X
X#define	VALUE(cptr)	((cptr == (char *) NULL) ? "NULL" : cptr)
X
Xint	errors = 0;
X
Xint	nextentry(), parseGtab(), findsym();
Xchar	*nextword();
Xvoid	addfield(), chkerr();
X
X
X/*
X**	gtabvalue() - find a gettytab entry that matches "id."
X**
X**	Returns (GTAB *)NULL if not found or an error occurs.
X*/
X
XGTAB *
Xgtabvalue(id, mode)
Xregister char *id;
Xint mode;
X{
X	register int state;
X	register char *p;
X	register char *gettytab;	/* gettytab file to use */
X	STDCHAR buf[MAXLINE+1];		/* buffer for Gtab entries */
X	char buf_id[MAXID+1];		/* buffer to compare initial label */
X	char *this = "First";		/* First or Next entry */
X	static GTAB gtab;		/* structure to be returned */
X	FILE *fp;
X
X	debug3(D_GTAB, "gtabvalue(%s) called\n", VALUE(id));
X
X	gettytab = (Check) ? CheckFile : GETTYTAB;
X	debug3(D_GTAB, "gettytab=%s\n", gettytab);
X
X	/* open the gettytab file
X	 */
X	if ((fp = fopen(gettytab, "r")) == (FILE *) NULL) {
X		(void) sprintf(MsgBuf, "cannot open %s", gettytab);
X		logerr(MsgBuf);
X		return(&Default);
X	}
X
X	/* search through the file for "id", unless
X	 * id is NULL, in which case we drop down
X	 * to get the 'default' entry.
X	 */
X	state = (!Check && (id == (char *) NULL)) ? QUIT : ENTRY;
X
X	while (state != QUIT && nextentry(buf, sizeof(buf), fp) == SUCCESS) {
X		if (buf[0] == '#' || buf[0] == '\n')
X			continue;	/* keep looking */
X		if (Check) {
X			(void) printf("*** %s Entry ***\n", this);
X			(void) printf("%s\n", buf);
X			this = "Next";
X		}
X		if (buf[strlen(buf)-1] != '\n') {
X			/* last char not \n, line is too long */
X			chkerr("line too long", FAIL);
X			state = QUIT;
X			continue;
X		}
X		/* get the first (label) field
X		 */
X		(void) strncpy(buf_id, buf, MAXID);
X		if ((p = strtok(buf_id, "# \t")) != (char *) NULL)
X			*(--p) = '\0';
X		/* if Check is set, parse all entries;
X		 * otherwise, parse only a matching entry
X		 */
X		if (Check || strequal(id, buf_id)) {
X			if (parseGtab(&gtab, buf) == FAIL) {
X				chkerr("*** Invalid Entry ***", FAIL);
X				state = QUIT;
X				continue;
X			}
X			if (!Check) {
X				(void) fclose(fp);
X				goto success;
X			}
X		}
X	}
X
X	if (Check) {
X		if (errors)
X			(void) printf("*** %d errors found ***\n", errors);
X		(void) printf("*** Check Complete ***\n");
X		(void) fclose(fp);
X		return((GTAB *) NULL);
X	}
X
X	if (mode == G_FIND)
X		return((GTAB *) NULL);
X
X	if (id != (char *) NULL) {
X		(void) sprintf(MsgBuf, "%s entry for \"%s\" not found",
X				gettytab, id);
X		logerr(MsgBuf);
X	}
X
X	/* matching entry not found or defective;
X	 * use the first line of the file
X	 */
X	rewind(fp);
X	(void) nextentry(buf, sizeof(buf), fp);
X	(void) fclose(fp);
X	if (parseGtab(&gtab, buf) == FAIL)
X		return(&Default);	/* punt: first line defective */
X
X    success:
X	debug2(D_GTAB, "gtabvalue() successful\n");
X	return(&gtab);
X}
X
X
X/*
X**	nextentry() - retrieve next entry from gettytab file
X**
X**	Returns FAIL if an error occurs.
X*/
X
Xint
Xnextentry(buf, len, stream)
Xregister char *buf;
Xregister int len;
XFILE *stream;
X{
X	register int count = 0;
X	STDCHAR line[MAXLINE+1];
X
X	*buf = '\0';		/* erase buffer */
X
X	while (fgets(line, sizeof(line), stream) != (char *) NULL) {
X		debug2(D_GTAB, "line read = (");
X		debug1(D_GTAB, line);
X		debug2(D_GTAB, ")\n");
X		if (count)
X			buf[strlen(buf)-1] = '\0';
X		if ((count += strlen(line)) >= len)
X			return(FAIL);		/* entry too long */
X		(void) strcat(buf, line);
X		if (line[0] == '\n')
X			return(SUCCESS);	/* blank line */
X	}
X
X	return(QUIT);
X}
X
X
X/*
X**	parseGtab() - fill in GTAB structure from buffer
X**
X**	Returns FAIL if an error occurs.
X*/
X
Xint
XparseGtab(gtab, line)
XGTAB *gtab;
Xregister char *line;
X{
X	register int field;
X	register char *p;
X	static int count;
X	static char p_cur[MAXID+1], p_next[MAXID+1];
X	static char p_login[MAXLOGIN+1];
X
X	debug2(D_GTAB, "parseGtab() called\n");
X
X	/* initialize gtab to empty
X	 */
X	gtab->cur_id = (char *) NULL;
X	gtab->itermio.c_iflag = 0;
X	gtab->itermio.c_oflag = 0;
X	gtab->itermio.c_cflag = 0;
X	gtab->itermio.c_lflag = 0;
X	gtab->itermio.c_line  = 0;
X	gtab->ftermio.c_iflag = 0;
X	gtab->ftermio.c_oflag = 0;
X	gtab->ftermio.c_cflag = 0;
X	gtab->ftermio.c_lflag = 0;
X	gtab->ftermio.c_line  = 0;
X	gtab->login = (char *) NULL;
X	gtab->next_id = (char *) NULL;
X
X	if (LineD != (char *) NULL) {	/* line disc given on command line */
X		addfield(&(gtab->itermio), LineD);
X		addfield(&(gtab->ftermio), LineD);
X	}
X
X	/* parse the line
X	 */
X	debug2(D_GTAB, "parsing line:\n");
X	field = 1;
X	while (field != FAIL && field != SUCCESS) {
X		if ((p = nextword(line, &count)) == (char *) NULL) {
X			field = FAIL;
X			continue;
X		}
X		debug4(D_GTAB, "field=%d, nextword=(%s)\n", field, p);
X		switch (field) {
X		case 1:
X			/* cur_id label
X			 */
X			(void) strncpy(p_cur, p, MAXID);
X			gtab->cur_id = p_cur;
X			field++;
X			break;
X		case 2:
X			/* '#' field separator
X			 */
X			if (*p != '#') {
X				field = FAIL;
X				continue;
X			}
X			field++;
X			break;
X		case 3:
X			/* initial termio flags
X			 */
X			if (*p == '#')
X				field++;
X			else
X				addfield(&(gtab->itermio), p);
X			break;
X		case 4:
X			/* final termio flags
X			 */
X			if (*p == '#')
X				field++;
X			else
X				addfield(&(gtab->ftermio), p);
X			break;
X		case 5:
X			/* login message --
X			 * nextword won't be the whole message; look
X			 * ahead to the next '#' and terminate string there
X			 */
X			if ((p = index(line, '#')) == (char *) NULL) {
X				field = FAIL;
X				continue;
X			}
X			*p = '\0';
X			p = line;		/* point p to line again */
X			count = strlen(p)+1;	/* adjust count accordingly */
X			debug3(D_GTAB, "login=(%s)\n", p);
X			(void) strncpy(p_login, p, MAXLOGIN);
X			gtab->login = p_login;
X			field++;
X			break;
X		case 6:
X			/* next_id label
X			 */
X			(void) strncpy(p_next, p, MAXID);
X			gtab->next_id = p_next;
X			field = SUCCESS;
X			continue;
X		}
X		/* skip over word just processed
X		 */
X		line += count;
X	}
X
X	if (Check) {
X		(void) printf("id: \"%s\"\n", gtab->cur_id);
X		(void) printf("initial termio flags:\n");
X		(void) printf(" iflag: %o, oflag: %o, cflag: %o, lflag: %o\n",
X				gtab->itermio.c_iflag, gtab->itermio.c_oflag,
X				gtab->itermio.c_cflag, gtab->itermio.c_lflag);
X		(void) printf(" line disc: %o\n", gtab->itermio.c_line);
X		(void) printf("final termio flags:\n");
X		(void) printf(" iflag: %o, oflag: %o, cflag: %o, lflag: %o\n",
X				gtab->ftermio.c_iflag, gtab->ftermio.c_oflag,
X				gtab->ftermio.c_cflag, gtab->ftermio.c_lflag);
X		(void) printf(" line disc: %o\n", gtab->ftermio.c_line);
X		(void) printf("login prompt: \"%s\"\n", gtab->login);
X		(void) printf("next id: \"%s\"\n\n", gtab->next_id);
X	}
X
X	return(field);
X}
X
X
X/*
X**	nextword() - get next "word" from buffer
X*/
X
Xchar *
Xnextword(buf, count)
Xregister char *buf;
Xregister int *count;
X{
X	register int num = 0;
X	register char *p;
X	static char word[MAXLINE+1];
X
X	while (*buf == ' ' || *buf == '\t' || *buf == '\\' ||
X	       *buf == '\n') {	/* skip leading whitespace */
X		buf++; num++;
X	}
X	p = word;
X	if (*buf == '#') {	/* first char is '#' ? */
X		*p++ = *buf;
X		num++;
X	} else {
X		while (*buf != ' ' && *buf != '\t' && *buf != '\\' &&
X		       *buf != '#' && *buf != '\n') {
X			*p++ = *buf++;
X			num++;
X		}
X	}
X	*p = '\0';
X	*count = num;
X	return(word);
X}
X
X
X/*
X**	addfield() - add symbol to termio structure
X*/
X
Xvoid
Xaddfield(termio, field)
Xregister TERMIO *termio;
Xregister char *field;
X{
X	register int val;
X
X	if (strequal(field, "SANE")) {
X		termio->c_iflag |= ISANE;
X		termio->c_oflag |= OSANE;
X		termio->c_cflag |= CSANE;
X		termio->c_lflag |= LSANE;
X	} else {
X		if ((val = findsym(field, imodes)) != FAIL)
X			termio->c_iflag |= (ushort) val;
X		else if ((val = findsym(field, omodes)) != FAIL)
X			termio->c_oflag |= (ushort) val;
X		else if ((val = findsym(field, cmodes)) != FAIL)
X			termio->c_cflag |= (ushort) val;
X		else if ((val = findsym(field, lmodes)) != FAIL)
X			termio->c_lflag |= (ushort) val;
X		else if ((val = findsym(field, ldiscs)) != FAIL)
X			termio->c_line |= (ushort) val;
X		else if (Check) {
X			(void) sprintf(MsgBuf, "undefined symbol: %s", field);
X			chkerr(MsgBuf, OK);
X		}
X	}
X}
X
X
X/*
X**	findsym() - look for field in SYMTAB list
X*/
X
Xint
Xfindsym(field, symtab)
Xregister char *field;
Xregister SYMTAB *symtab;
X{
X	for (; symtab->symbol != (char *) NULL; symtab++)
X		if (strequal(symtab->symbol, field))
X			return((int) symtab->value);
X
X	return(FAIL);
X}
X
X
X/*
X**	chkerr() - display error message from check routines
X*/
X
Xvoid
Xchkerr(msg, status)
Xchar *msg;
Xint status;
X{
X	(void) printf("*** parsing error: %s ***\n", msg);
X	if (status)
X		(void) printf("*** checking halted ***\n");
X	else
X		(void) printf("*** checking continued ***\n");
X
X	errors++;
X}
X
X
X/* end of table.c */
!STUFFY!FUNK!
echo Extracting release.h
sed >release.h <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: release.h,v 2.0 90/09/19 20:16:46 paul Rel $
X**
X**	Getty release/date
X*/
X
X
X/* these are used by the man pages, too
X */
X#define	RELEASE		"2.0"		/* release number */
X#define	DATE		"19-Sep-90"	/* release date */
X
X
X/* end of release.h */
!STUFFY!FUNK!
echo ""
echo "End of kit 1 (of 5)"
cat /dev/null >kit1isdone
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
