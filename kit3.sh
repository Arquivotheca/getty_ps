#! /bin/sh

# Make a new directory for the getty sources, cd to it, and run kits 1
# thru 5 through sh.  When all 5 kits have been run, read README.

echo "This is getty 2.0 kit 3 (of 5).  If kit 3 is complete, the line"
echo '"'"End of kit 3 (of 5)"'" will echo at the end.'
echo ""
export PATH || (echo "You didn't use sh, you clunch." ; kill $$)
mkdir man 2>/dev/null
echo Extracting man/getty.m4
sed >man/getty.m4 <<'!STUFFY!FUNK!' -e 's/X//'
X.\" +----------
X.\" |	$Id: getty.m4,v 2.0 90/09/19 20:11:33 paul Rel $
X.\" |
X.\" |	GETTY/UUGETTY man page.
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
X.\" |	$Log:	getty.m4,v $
X.\" |	Revision 2.0  90/09/19  20:11:33  paul
X.\" |	Initial 2.0 release
X.\" |	
X.\" |	
X.\" 
X.\" +----------
X.\" | M4 configuration
X.\"
Xinclude(config.m4).\"
X.\"
X.\" define(`_gtab_file_', _gtab_`_file')
X.\"
X.\" +----------
X.\" | Manpage source follows:
X.\"
X.TH GETTY _mcmd_section_ "DATE" "Release RELEASE"
X.SH NAME
Xgetty \- sets terminal mode, speed, and line discipline
X.SH SYNOPSIS
X.B /etc/getty
X.\" +----------
X.\" | M4_start (trs16)
Xifdef(`trs16',
X.B speed
X.I [defaults_file],
X.\" | else (trs16)
X[\-d
X.I defaults_file]
X[\-a] [\-h] [\-r
X.I delay]
X[\-t
X.I timeout]
X[\-w
X.I waitfor]
X.B line
X.I [speed [type [lined]]])
X.\" | M4_end (trs16)
X.\" +----------
X.br
X.B /etc/getty \-c
X.I _gtab_file_
X.SH DESCRIPTION
X.I Getty
Xis the second of the three programs
X.IR (init (_mcmd_section_),
X.IR getty (_mcmd_section_),
Xand
X.IR login (_mcmd_section_)),
Xused by the
X.\" +----------
X.\" | M4_start
Xifdef(`M_XENIX', XENIX, .\")
Xifdef(`XENIX', XENIX, .\")
Xifdef(`UNIX', UNIX, .\")
X.\" | M4_end
X.\" +----------
Xsystem to allow users to login.
X.I Getty
Xis invoked by
X.IR init (_mcmd_section_)
Xto:
X.br
X.TP 3
X1.
XOpen tty lines and set their modes.
X.TP
X2.
XPrint the login prompt, and get the user's name.
X.TP
X3.
XInitiate a login process for the user.
X.P
XThe actual procedure that
X.I getty
Xfollows is described below:  Initially,
X.I getty
Xparses its command line.  If no errors are found,
X.I getty
Xscans the defaults file (normally
X.BR _defaults_`/getty' )
Xto determine certain runtime values.  The values in the defaults file
X(whose compiled\-in name can be altered with the optional
X.\" +----------
X.\" | M4_start (trs16)
Xifdef(`trs16', .\", .B \-d)
X.\" | M4_end (trs16)
X.\" +----------
X.I defaults_file
Xargument) take precedence to those on the command line.
X.I Getty
Xthen opens the
X.I line
Xfor reading and writing, and disables stdio buffering.
X.\" +----------
X.\" | M4_start (logutmp)
Xifdef(`logutmp',
XThe
X.IR utmp (_file_section_)
Xand
X.IR wtmp (_file_section_)
X(if it exists) files are updated to indicate a LOGIN_PROCESS.,
X.\" | else (logutmp)
X.\")
X.\" | M4_end (logutmp)
X.\" +----------
XIf an initialization was specified, it is performed (see LINE
XINITIALIZATION).
X.PP
XNext,
X.I getty
Xtypes the
X.\" +----------
X.\" | M4_start (issue)
Xifdef(`_issue_',
Xissue `(or login banner,' usually from
X.BR _issue_ `)'
Xand,
X.\" | else (issue)
X.\")
X.\" | M4_end (issue)
X.\" +----------
Xlogin prompt.  Finally,
X.I getty
Xreads the user's login name and invokes
X.IR login (_mcmd_section_)
Xwith the user's name as an argument.  While reading the name,
X.I getty
Xattempts to adapt the system to the speed of the terminal being used,
Xand also sets certain terminal parameters (see
X.\" +----------
X.\" | M4_start (trs16)
Xifdef(`trs16',
X.IR tty `('_misc_section_`))',
X.\" | else (trs16)
X.IR termio `('_misc_section_`))')
X.\" | M4_end (trs16)
X.\" +----------
Xto conform with the user's login procedure.
X.PP
XThe tty device used by
X.I getty
Xis determined by
X.\" +----------
X.\" | M4_start (trs16)
Xifdef(`trs16',
Xa call to
X.IR ttyname (S)`,'
Xwhich sets the
X.I line
Xvalue.,
X.\" | else (trs16)
Xthe
X.I line
Xargument.)
X.\" | M4_end (trs16)
X.\" +----------
X.I Getty
Xuses the string
X.BI /dev/ line
Xas the name of the device to attach itself to.  Unless
X.I getty
Xis invoked with the
X.B \-h
Xflag (or
X.B HANGUP=NO
Xis specified in the defaults file), it will force a hangup on the line
Xby setting the speed to zero.  Giving
X.B \-r
X.I delay
Xon the command line (or using
X.B WAITCHAR=YES
Xand
X.BI DELAY= delay
Xin the defaults file) will cause
X.I getty
Xto wait for a single character from the line, and then to wait
X.I delay
Xseconds before continuing.  If no delay is desired, use
X.BR \-r0 .
XGiving
X.B \-w
X.I waitfor
Xon the command line (or using
X.BI WAITFOR= waitfor
Xin the defaults file) will cause
X.I getty
Xto wait for the specified string of characters from the line
Xbefore continuing.  Giving
X.B \-t
X.I timeout
Xon the command line (or using
X.BR TIMEOUT= timeout
Xin the defaults file) will cause
X.I getty
Xto exit if no user name is accepted within
X.I timeout
Xseconds after the login prompt is typed.
X.PP
XThe
X.I speed
Xargument is a label to a entry in the
X.B _gettytab_
Xfile (see
X.IR _gtab_ `('_file_section_)).
XThis entry defines to
X.I getty
Xthe initial speed (baud rate) and tty settings, the login prompt to be
Xused, the final speed and tty settings, and a pointer to another entry
Xto try should the user indicate that the speed is not correct.  This
Xis done by sending a
X.I <break>
Xcharacter (actually sequence).  Under certain conditions, a
Xcarriage\-return will perform the same function.  This is usually the
Xcase when getty is set to a higher speed than the modem or terminal.
X.I Getty
Xscans the _gtab_ file sequentially looking for a matching entry.
X.\" +----------
X.\" | M4_start (trs16)
Xifdef(`trs16',
XIf an entry for the given
X.I speed,
X.\" | else (trs16)
XIf no
X.I speed
Xwas given or the entry)
X.\" | M4_end (trs16)
X.\" +----------
Xcannot be found, the first entry in the
X.B _gettytab_
Xfile is used as a default.  In the event that the _gtab_ file cannot be
Xaccessed`,' there is a compiled\-in default entry that is used.
X.PP
X.\" +----------
X.\" | M4_start (trs16)
Xifdef(`trs16',
XThe terminal type is determined by examining the
X.I ttytype
Xfile`,' using the value associated with
X.I line.
X.I Getty
Xuses this value to determine how to clear the video display.,
X.\" | else (trs16)
XThe
X.I type
Xargument is a string which names the type of terminal attached to the
Xline.  The
X.I type
Xshould be a valid terminal name listed in the
X.\" +----------
X.\" | M4_start (termcap)
Xifdef(`termcap',
X.BR termcap (_misc_section_),
X.\" | else (termcap)
X.BR terminfo (_misc_section_))
X.\" | M4_end (termcap)
X.\" +----------
Xdatabase.
X.\" +----------
X.\" | M4_start (ttytype)
Xifdef(`ttytype',
XIf no
X.I type
Xis given on the command line`,' one is deduced from the
X.B ttytype
Xfile.,
X.\" | else (ttytype)
X.\")
X.\" | M4_end (ttytype)
X.\" +----------
X.I Getty
Xuses this value to determine how to clear the video display.
X.PP
XThe
X.I lined
Xargument is a string describing the line discipline to use on the
Xline.  The default is
X.BR LDISC0 .)
X.\" | M4_end (trs16)
X.\" +----------
X.PP
XAs mentioned,
X.I getty
Xtypes the login prompt and then reads the user's login name.  If a
Xnull character is received, it is assumed to be the result of the user
Xpressing the
X.I <break>
Xkey or the carriage\-return key to indicate the speed is wrong.  This
Xcauses
X.I getty
Xto locate the next
X.I speed
Xin the series (defined in _gettytab_).
X.PP
XThe user's name is terminated by a new\-line or carriage\-return
Xcharacter.  A carriage\-return results in the system being set to map
Xthose to new\-lines (see
X.IR ioctl (_system_section_)).
X.PP
XThe user's name is scanned to see if it contains only upper\-case
Xcharacters.  If so,
X.\" +----------
X.\" | M4_start (warncase)
Xifdef(`warncase',
Xa warning is issued to the user to retry his login`,' using lower\-case
Xif possible.  If the second attempt is still all upper\-case`,',
X.\" | else (warncase)
X.\")
X.\" | M4_end (warncase)
X.\" +----------
Xthe system is set to map any future upper\-case characters into
Xlower\-case.
X.PP
XA check option is provided for testing the _gtab_ file.  When
X.I getty
Xis invoked with the
X.BI \-c _gtab_
Xoption, it scans the named
X.I _gtab_
Xfile and prints out (to the standard output) the values it sees.  If
Xany parsing errors occur (due to errors in the syntax of the _gtab_
Xfile), they are reported.
X.SH "DEFAULTS FILE"
XDuring its startup,
X.I getty
Xlooks for the file
X.BI _defaults_`/getty' .line,
X(or, if it cannot find that file, then
X.BR _defaults_`/getty' ),
Xand if found, reads the contents for lines of the form
X
X.in +.5i
XNAME=\fIvalue\fR
X.in -.5i
X
XThis allows getty to have certain features configurable at runtime,
Xwithout recompiling.  The recognized NAME strings, and their
Xcorresponding values, follows:
X.TP 6
XSYSTEM=\fIname\fR
XSets the nodename value (displayed by
X.B @S
X\-\- see PROMPT SUBSTITUTIONS) to
X.IR name .
XThe default is the
X.I nodename
Xvalue returned by the
X.IR uname (_library_section_)
Xcall.  On XENIX systems, if the value of nodename is a zero\-length
Xstring, the file
X.B /etc/systemid
Xis examined to get the nodename.
XNote that some sites may have elected to compile the nodename value
Xinto
X.IR getty .
X.TP
XVERSION=\fIstring\fR
XSets the value that is displayed by the
X.B @V
Xparameter (see PROMPT SUBSTITUTIONS) to
X.I string.
XThere is no default value.  If
X.I string
Xbegins with a '/' character, it is assumed to be the full pathname of a
Xfile, and
X.B @V
Xis set to be the contents of that file.
X.TP
XLOGIN=\fIname\fR
XSets the name of the login program to
X.I name.
XThe default is
X.B _login_
X(see
X.IR login (_mcmd_section_)).
XIf used,
X.I name
Xmust be the full pathname of the program that
X.I getty
Xwill execute instead of
X.BR _login_ .
XNote that this program is called, as is
X.BR _login_ ,
Xthe with the user's name as its only argument.
X.TP
XINIT=\fIstring\fR
XIf defined,
X.I string
Xis an expect/send sequence that is used to initialize the line before
X.I getty
Xattempts to use it.  This string is in a form resembling that used in
Xthe
X.I _systems_
Xfile of
X.IR uucp (_cmd_section_).
XFor more details, see LINE INITIALIZATION.  By default, no
Xinitialization is done.
X.\" +----------
X.\" | M4_start (issue)
Xifdef(`_issue_',
X.TP
XISSUE=\fIstring\fR
XDuring startup`,'
X.I getty
Xdefaults to displaying`,' as an issue or login banner`,' the contents of
Xthe
X.B _issue_
Xfile.  If ISSUE is defined to a
X.I string`,'
Xthat string is typed instead.  If
X.I string
Xbegins with a '/' character`,' it is assumed to be the full pathname of
Xa file`,' and that file is used instead of
X.BR _issue_ .,
X.\" | else (issue)
X.\")
X.\" | M4_end (issue)
X.\" +----------
X.TP
XCLEAR=\fIvalue\fR
XIf
X.I value
Xis
X.BR NO ,
Xthen 
X.I getty
Xwill not attempt to clear the video screen before typing the
X.\" +----------
X.\" < M4_start (issue)
Xifdef(`_issue_',
Xissue or login prompts.,
X.\" | else (issue)
Xlogin prompt.)
X.\" | M4_end (issue)
X.\" +----------
XThe default is to clear the screen.
X.TP
XHANGUP=\fIvalue\fR
XIf
X.I value
Xis
X.BR NO ,
Xthen
X.I getty
Xwill NOT hangup the line during its startup.  This is analogus to
Xgiving the
X.B \-h
Xargument on the command line.
X.TP
XWAITCHAR=\fIvalue\fR
XIf
X.I value
Xis
X.BR YES ,
Xthen
X.I getty
Xwill wait for a single character from it's line before continuing.
XThis is useful for modem connections where the modem has CD forced
Xhigh at all times, to keep getty from endlessly chatting with the
Xmodem.
X.TP
XDELAY=\fIseconds\fR
XUsed in conjunction with
X.BR WAITCHAR ,
Xthis adds a time delay of
X.I seconds
Xafter the character is accepted before allowing
X.I getty
Xto continue.  Both
X.B WAITCHAR
Xand
X.B DELAY
Xhave the same effect as specifying
X.BI \-r delay
Xon the command line.
XIf
X.B WAITCHAR
Xis given without a
X.BR DELAY ,
Xthe result is equal to having said
X.B \-r0
Xon the command line.
XThe default is to not wait for a character.
X.TP
XTIMEOUT=\fInumber\fR
XAs with the
X.B \-t
X.I timeout
Xcommand line argument, tells
X.I getty
Xto exit if no user name is accepted before the
X.I number
Xof seconds elapse after the login prompt is typed.
XThe default is to wait indefinetly for the user name.
X.TP
XCONNECT=\fIstring\fR
XIf defined,
X.I string
Xshould be an expect/send sequence (like that for INIT) to direct
X.I getty
Xin establishing the connection.
X.I String
Xmay be defined as
X.BR DEFAULT ,
Xwhich will substitute the built\-in string:
X
X.in +.5i
X.nf
X_connect_
X.fi
X.in -.5i
X
XThe \\A escape marks the place where the digits showing the speed
Xwill be seen.  See CONNECTION AND AUTOBAUDING for more details.
XThe default is to not perform a connection chat sequence.
X.TP
XWAITFOR=\fIstring\fR
XThis parameter is similar to WAITCHAR, but defines a string of
Xcharacters to be waited for.
X.I Getty
Xwill wait until
X.I string
Xis received before issuing the login prompt.
XThis parameter is best used when combined with CONNECT, as in
Xthis example:
X
X.in +.5i
X.nf
XWAITFOR=RING
XCONNECT="" ATA\\r CONNECT\\s\\A
X.fi
X.in -.5i
X
XThis would cause
X.I getty
Xto wait for the string
X.BR RING ,
Xthen expect nothing, send
X.B ATA
Xfollowed by a carriage\-return, and then wait for a string such as
X.BR "CONNECT 2400" ,
Xin which case,
X.I getty
Xwould set itself to 2400 baud.
XThe default is not to wait for any string of characters.
X.TP
XALTLOCK=\fIline\fR
X.I Uugetty
Xuses this parameter to lock an alternate device, in addition to the
Xone it is attached to.  This is for those systems that have two
Xdifferent device names that refer to the same physical port; e.g.
X/dev/tty1A vs. /dev/tty1a, where one uses modem control and the
Xother doesn't.  See the section on UUGETTY for more details.
XThe default is to have no alternate lockfile.
X.P
XThe name of the defaults file can be changed by specifying
X.\" +----------
X.\" | M4_start (trs16)
Xifdef(`trs16',
X.\" Nothing,
X.\" | else (trs16)
X.B \-d)
X.\" | M4_end (trs16)
X.\" +----------
X.I defaults_file
Xon the command line.  If
X.I defaults_file
Xbegins with a slash, it is assumed to be a complete pathname of the
Xdefaults file to be used.  Otherwise, it is assumed to be a regular
Xfilename, causing
X.I getty
Xto use the pathname
X.BI _defaults_ `/defaults_file.'
X.SH "PROMPT SUBSTITUTIONS"
XWhen
X.I getty
Xis typing
X.\" +----------
X.\" | M4_start (issue)
Xifdef(`_issue_',
Xthe issue or login banner (ususally
X.BR _issue_ )`,'
Xor,
X.\" | else (issue)
X.\")
X.\" | M4_end (issue)
X.\" +----------
Xthe
X.I login\-prompt,
Xit recognizes several escape (quoted) characters.  When one of these
Xquoted characters is found, its value is substituted in the output
Xproduced by
X.I getty.
XRecognized escape characters are:
X.br
X.TP 6
X\\\\\\\\\\\\\\\\
XBackslash (\\).
X.TP
X\\\\\\\\b
XBackspace (^H).
X.TP
X\\\\\\\\c
XPlaced at the end of a string, this prevents a new\-line from
Xbeing typed after the string.
X.TP
X\\\\\\\\f
XFormfeed (^L).
X.TP
X\\\\\\\\n
XNew\-line (^J).
X.TP
X\\\\\\\\r
XCarriage\-return (^M).
X.TP
X\\\\\\\\s
XA single space (' ').
X.TP
X\\\\\\\\t
XHorizontal tab (^I).
X.TP
X\\\\\\\\\fInnn\fR
XOutputs the ASCII character whose decimal value is
X.IR nnn .
XIf
X.I nnn
Xbegins with 0, the value is taken to be in octal.  If it begins
Xwith 0x, the value is taken to be in hexidecimal.
X.P
XIn addition, a single backslash at the end of a line causes the
Ximmediately following new\-line to be ignored, allowing continuation
Xlines.
X.PP
XAlso, certain
X.BI "@" char
Xparameters are recognized.  Those parameters, and the value that is
Xsubstituted for them are:
X.TP 6
X at B
XThe current (evaluated at the time the
X.B @B
Xis seen) baud rate.
X.TP
X at D
XThe current date, in MM/DD/YY format.
X.TP
X at L
XThe
X.I line
Xto which
X.I getty
Xis attached.
X.TP
X at S
XThe system node name.
X.TP
X at T
XThe current time, in HH:MM:SS (24-hour) format.
X.TP
X at U
XThe number of currently signed\-on users.  This is a count of the
Xnumber of entries in the
X.I _utmp_
Xfile
X.\" +----------
X.\" | M4_start (logutmp)
Xifdef(`logutmp',
Xwhose ut_type field is USER_PROCESS.,
X.\" | else (logutmp)
Xthat have a non\-null ut_name field.)
X.\" | M4_end (logutmp)
X.\" +----------
X.TP
X at V
XThe value of
X.BR VERSION ,
Xas given in the defaults file.
X.P
XTo display a single '@' character, use either '\\@' or '@@'.
X.SH "LINE INITIALIZATION"
XOne of the greatest benefits (in the author's opinion, at least) is
Xthe ability of
X.I getty
Xto initialize its line before use.  This will most likely be done on
Xlines with modems, not terminals, although initializing terminals is
Xnot out of the question.
X.PP
XLine initialization is performed just after the
X.I line
Xis opened and prior to handling the WAITCHAR and/or WAITFOR options.
XInitialization is accomplished by placing an
X
X.in +.5i
XINIT=\fIstring\fR
X.in -.5i
X
Xline in the defaults file.
X.I String
Xis a series of one or more fields in the form
X
X.in +.5i
Xexpect [ send [ expect [ send ] ] ... ]
X.in -.5i
X
XThis format resembles the expect/send sequences used in the UUCP
X.I _systems_
Xfile, with the following exception:
XA carriage return is NOT appended automatically to sequences that
Xare 'sent.'  If you want a carriage\-return sent, you must explicitly
Xshow it, with '\\r'.
X.PP
X.I Getty
Xsupports subfields in the expect field of the form
X
X.in +.5i
Xexpect[\-send\-expect]...
X.in -.5i
X
Xas with UUCP.  All the escape characters (those beginning with a '\\'
Xcharacter) listed in the PROMPT SUBSTITUTIONS section are valid in
Xthe send and expect fields.
XIn addition, the following escape characters are recognized:
X.br
X.TP 6
X\\\\\\\\p
XInserts a 1\-second delay.
X.TP
X\\\\\\\\d
XInserts a 2\-second delay.
X.TP
X\\\\\\\\K
XSends a .25\-second Break.
X.TP
X\\\\\\\\T\fInnn\fR
XModifies the default timeout (usually 30 seconds) to
Xthe value indicated by
X.IR nnn .
XThe value
X.I nnn
Xmay be decimal, octal, or hexidecimal; see the usage of
X\fB\\\fInnn\fR in PROMPT SUBSTITUTIONS.
X.P
XNote that for these additional escape characters, no actual
Xcharacter is sent.
X.SH "CONNECTION AND AUTOBAUDING"
X.I Getty
Xwill perform a chat sequence establish a proper connection.
XThe best use of this feature is to look for the
X.B CONNECT
Xmessage sent by a modem and set the line speed to the number given
Xin that message (e.g. CONNECT 2400).  
X.PP
XThe format for the connect chat script is exactly the same as that
Xfor the INIT script (see LINE INITIALIZATION), with the following
Xaddition:
X.br
X.TP 6
X\\\\\\\\A
XMarks the spot where the baud rate will be seen.  This mark will
Xmatch any and all digits 0\-9 at that location in the script, and
Xset it's speed to that value, if possible.
X.P
XAutobauding, therefore, is enabled by placing the
X.B \\\\A
Xmark in the chat script.  For example, the definition:
X
X.in+.5i
XCONNECT=CONNECT\\s\\A
X.in-.5i
X
Xwould match the string
X.B "CONNECT 1200"
Xand cause
X.I getty
Xto set it's baud rate to 1200, using the following steps:
X.TP 3
X1.
XHaving matched the value 1200,
X.I getty
Xwill attempt to find an entry with the label
X.B 1200
Xin the
X.B _gtab_
Xfile.  If a matching _gtab_ entry is found, those values are
Xused.  If there is no match, then
X.TP
X2.
XThe _gtab_ values currently in use are modified to use the
Xmatched speed (e.g. 1200).  However, if the matched speed
Xis invalid, then
X.TP
X3.
X.I Getty
Xlogs a warning message and resumes normal operation.  This
Xallows the practice of toggling through linked entries in the
X_gtab_ file to behave as expected.
X.P
X.SH UUGETTY
X.I Uugetty
Xhas identical behavior to
X.I getty,
Xexcept that
X.I uugetty
Xis designed to create and use the lock files maintained by the UUCP
Xfamily
X.IR (uucp (_cmd_section_),
X.IR cu (_cmd_section_)
Xand others).  This prevents two or more processes from having conficting
Xuse of a tty line.
X.PP
XWhen
X.I uugetty
Xstarts up, if it sees a lock file on the line it intends to use,
Xit will use the pid in the lock file to see if there is an active
Xprocess holding the lock.  If not,
X.I uugetty
Xwill remove the lock file and continue.  If a valid process is found,
X.I uugetty
Xwill sleep until that process releases the lock and then it will exit,
Xforcing
X.IR init (_mcmd_section_)
Xto spawn a new
X.I uugetty.
XOnce no conflicting process is found,
X.I uugetty
Xgrabs the
X.I line
Xby creating the lock file itself before issuing the login prompt.
XThis prevents other processes from using the line.
X.PP
X.I Uugetty
Xwill normally only lock the name of the line it is running on.  On
Xsystems where there are two device names referring to the same port
X(as is the case where one device uses modem control while the other
Xdoesn't), place a line of the form
X
X.in +.5i
XALTLOCK=\fIline\fR
X.in -.5i
X
Xline in the defaults file.  For instance, if
X.I uugetty
Xis on
X.I /dev/tty1a,
Xand you want to have it lock
X.I /dev/tty1A
Xalso, use the line
X.B ALTLOCK=tty1A
Xin the defaults file.
X.SH FILES
X.TP 16
X_console_
XThe device to which errors are reported.
X.\" +----------
X.\" | M4_start (trymail)
Xifdef(`trymail',
XIf the device is for some reason unavailable (cannot be written to)`,'
Xa mail message containing the error is sent to the user
X.BR _notify_ .,
X.\" | else (trymail)
X.\")
X.\" | M4_end (trymail)
X.\" +----------
X.TP
X_defaults_`/getty[\fI.line\fR]'
XContains the runtime configuration.  Note that
X.I uugetty
Xuses _defaults_`/uugetty[\fI.line\fR].'
X.TP
X_gettytab_
XContains speed and tty settings to be used by
X.I getty.
X.\" +----------
X.\" | M4_start (issue)
Xifdef(`_issue_',
X.TP
X_issue_
XThe default issue (or login banner).
X.\" | else (issue)
X.\")
X.\" | M4_end (issue)
X.\" +----------
X.TP
X_login_
XThe default login program called after the user's name is entered.
X.\" +----------
X.\" | M4_start (ttytype)
Xifdef(`ttytype',
X.TP
X_ttytype_
XContains the terminal types for each line in the system.,
X.\" | else (ttytype)
X.\")
X.\" | M4_end (ttytype)
X.\" +----------
X.P
X.SH "SEE ALSO"
Xinit(_mcmd_section_),
Xlogin(_mcmd_section_),
Xuucp(_cmd_section_),
Xioctl(_system_section_),
Xuname(_library_section_),
X.\" +----------
X.\" | M4_start (issue)
Xifdef(`issue',
Xissue`('_file_section_`)',
X.\" | else (issue)
X.\")
X.\" | M4_end (issue)
X.\" +----------
X_gtab_`('_file_section_),
Xutmp(_file_section_),
X.\" +----------
X.\" | M4_start (trs16)
Xifdef(`trs16',
Xtty`('_misc_section_`)',
X.\" | else (trs16)
Xtermio`('_misc_section_`)')
X.\" | M4_end (trs16)
X.\" +----------
X.SH AUTHOR
X.nf
XPaul Sutcliffe, Jr.  <paul at devon.lns.pa.us>
XUUCP: ...!rutgers!devon!paul
X.br
X
XAutobauding routines adapted from code submitted by
XMark Keating <...!utzoo!censor!markk>
!STUFFY!FUNK!
echo Extracting funcs.c
sed >funcs.c <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: funcs.c,v 2.0 90/09/19 19:53:19 paul Rel $
X**
X**	Miscellaneous routines.
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
X**	$Log:	funcs.c,v $
X**	Revision 2.0  90/09/19  19:53:19  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X#include "getty.h"
X#include "table.h"
X#include <ctype.h>
X#ifdef	I_TIME
X#include <time.h>
X#endif	/* I_TIME */
X#ifdef	I_SYSTIME
X#include <sys/time.h>
X#endif	/* I_SYSTIME */
X#ifdef	DOUNAME
X#include <sys/utsname.h>
X#endif	/* DOUNAME */
X#include <setjmp.h>
X#include <signal.h>
X
X#if defined(RCSID) && !defined(lint)
Xstatic char *RcsId =
X"@(#)$Id: funcs.c,v 2.0 90/09/19 19:53:19 paul Rel $";
X#endif
X
X#ifndef	MAXBUF
X#define	MAXBUF	512	/* buffer size */
X#endif	/* MAXBUF */
X
X#ifndef	EXPFAIL
X#define	EXPFAIL	30	/* default num seconds to wait for expected input */
X#endif	/* EXPFAIL */
X
X#define	EXPECT	0	/* states for chat() */
X#define	SEND	1
X
X#define	AUTOBD	0376	/* marker for AutoBaud digits */
X
Xchar	*unquote();
Xint	expect(), send();
Xboolean	expmatch();
Xsig_t	expalarm();
X
X
X/*
X**	Fputs() - does fputs() with '\' and '@' expansion
X**
X**	Returns EOF if an error occurs.
X*/
X
Xint
XFputs(s, stream)
Xregister char *s;
Xregister FILE *stream;
X{
X	char c, n, tbuf[9], ubuf[32];
X	time_t clock;
X	struct tm *lt, *localtime();
X
X	while (c = *s++) {
X		if ((c == '@') && (n = *s++)) {
X			switch (n) {
X			case 'B':	/* speed (baud rate) */
X				if (*Speed && Fputs(Speed, stream) == EOF)
X					return(EOF);
X				break;
X			case 'D':	/* date */
X				(void) time(&clock);
X				lt = localtime(&clock);
X				(void) sprintf(tbuf, "%02d/%02d/%02d",
X						++(lt->tm_mon),
X						lt->tm_mday, lt->tm_year);
X				if (Fputs(tbuf, stream) == EOF)
X					return(EOF);
X				break;
X			case 'L':	/* line */
X				if (*Device && Fputs(Device, stream) == EOF)
X					return(EOF);
X				break;
X			case 'S':	/* system node name */
X				if (*SysName && Fputs(SysName, stream) == EOF)
X					return(EOF);
X				break;
X#ifdef	M_XENIX
X			/* Special case applys here: SCO XENIX's
X			 * /etc/gettydefs file has "\r\n@!login: " as
X			 * the login field value, and replaces the "@"
X			 * with the system node name.  This will do
X			 * the same thing.
X			 */
X			case '!':
X				if (*SysName && Fputs(SysName, stream) == EOF)
X					return(EOF);
X				(void) fputc(n, stream);
X				break;
X#endif	/* M_XENIX */
X			case 'T':	/* time */
X				(void) time(&clock);
X				lt = localtime(&clock);
X				(void) sprintf(tbuf, "%02d:%02d:%02d",
X						lt->tm_hour,
X						lt->tm_min, lt->tm_sec);
X				if (Fputs(tbuf, stream) == EOF)
X					return(EOF);
X				break;
X			case 'U':	/* number of active users */
X				(void) sprintf(ubuf, "%d", Nusers);
X				if (Fputs(ubuf, stream) == EOF)
X					return(EOF);
X				break;
X			case 'V':	/* version */
X				if (*Version && Fputs(Version, stream) == EOF)
X					return(EOF);
X				break;
X			case '@':	/* in case '@@' was used */
X				if (fputc(n, stream) == EOF)
X					return(EOF);
X				break;
X			}
X		} else {
X			if (c == '\\')
X				s = unquote(s, &c);
X			/* we're in raw mode: send CR before every LF
X			 */
X			if (c == '\n' && (fputc('\r', stream) == EOF))
X				return(EOF);
X			if (c && fputc(c, stream) == EOF)
X				return(EOF);
X		}
X	}
X	return(SUCCESS);
X}
X
X
X/*
X**	getuname() - retrieve the system's node name
X**
X**	Returns pointer to name or a zero-length string if not found.
X*/
X
Xchar *
Xgetuname()
X{
X#ifdef	HOSTNAME			/* hardwire the name */
X
X	static char name[] = HOSTNAME;
X
X	return(name);
X
X#else	/* HOSTNAME */
X
X#ifdef	M_XENIX
X#define	SYSTEMID "/etc/systemid"
X	static FILE *fp;
X#endif	/* M_XENIX */
X
X	struct utsname uts;
X	static char name[80];
X
X	name[0] = '\0';
X
X#ifdef	DOUNAME				/* dig it out of the kernel */
X
X	if (uname(&uts) != FAIL)
X		(void) strcpy(name, uts.nodename);
X
X#endif	/* DOUNAME */
X
X#ifdef	M_XENIX				/* if Xenix's uts.nodename is empty */
X	if (strlen(name) == 0) {
X		if ((fp = fopen(SYSTEMID, "r")) != (FILE *) NULL) {
X			(void) fgets(name, sizeof(name), fp);
X			(void) fclose(fp);
X			name[strlen(name)-1] = '\0';
X		}
X	}
X#endif	/* M_XENIX */
X
X#ifdef	PHOSTNAME			/* get it from the shell */
X
X	if (strlen(name) == 0) {
X		FILE *cmd;
X		if ((cmd = popen(PHOSTNAME, "r")) != (FILE *) NULL) {
X			(void) fgets(name, sizeof(name), cmd);
X			(void) pclose(cmd);
X			name[strlen(name)-1] = '\0';
X		}
X	}
X
X#endif	/* PHOSTNAME */
X
X	return(name);
X
X#endif	/* HOSTNAME */
X}
X
X
X/*
X**	settermio() - setup tty according to termio values
X*/
X
Xvoid
Xsettermio(termio, state)
Xregister TERMIO *termio;
Xint state;
X{
X	register int i;
X	static TERMIO setterm;
X
X#ifdef	TRS16
X	/* Tandy 16/6000 console's BREAK key sends ^C
X	 */
X	char Cintr = (strequal(Device, "console")) ? '\003' : CINTR;
X#else
X	char Cintr = CINTR;
X#endif	/* TRS16 */
X
X#ifdef	MY_ERASE
X	char Cerase = MY_ERASE;
X#else
X	char Cerase = CERASE;
X#endif	/* MY_ERASE */
X
X#ifdef	MY_KILL
X	char Ckill = MY_KILL;
X#else
X	char Ckill = CKILL;
X#endif	/* MY_KILL */
X
X	(void) ioctl(STDIN, TCGETA, &setterm);
X
X	switch (state) {
X	case INITIAL:
X		setterm.c_iflag = termio->c_iflag;
X		setterm.c_oflag = termio->c_oflag;
X		setterm.c_cflag = termio->c_cflag;
X		setterm.c_lflag = termio->c_lflag;
X		setterm.c_line  = termio->c_line;
X
X		/* single character processing
X		 */
X		setterm.c_lflag &= ~(ICANON);
X		setterm.c_cc[VMIN] = 1;
X		setterm.c_cc[VTIME] = 0;
X
X		/* sanity check
X		 */
X		if ((setterm.c_cflag & CBAUD) == 0)
X			setterm.c_cflag |= B9600;
X		if ((setterm.c_cflag & CSIZE) == 0)
X			setterm.c_cflag |= DEF_CFL;
X		setterm.c_cflag |= (CREAD | HUPCL);
X
X		(void) ioctl(STDIN, TCSETAF, &setterm);
X		break;
X
X	case FINAL:
X		setterm.c_iflag = termio->c_iflag;
X		setterm.c_oflag = termio->c_oflag;
X		setterm.c_cflag = termio->c_cflag;
X		setterm.c_lflag = termio->c_lflag;
X		setterm.c_line  = termio->c_line;
X
X		/* sanity check
X		 */
X		if ((setterm.c_cflag & CBAUD) == 0)
X			setterm.c_cflag |= B9600;
X		if ((setterm.c_cflag & CSIZE) == 0)
X			setterm.c_cflag |= DEF_CFL;
X		setterm.c_cflag |= CREAD;
X
X		/* set c_cc[] chars to reasonable values
X		 */
X		for (i=0; i < NCC; i++)
X			setterm.c_cc[i] = CNUL;
X		setterm.c_cc[VINTR] = Cintr;
X		setterm.c_cc[VQUIT] = CQUIT;
X		setterm.c_cc[VERASE] = Cerase;
X		setterm.c_cc[VKILL] = Ckill;
X		setterm.c_cc[VEOF] = CEOF;
X#ifdef	CEOL
X		setterm.c_cc[VEOL] = CEOL;
X#endif	/* CEOL */
X
X		(void) ioctl(STDIN, TCSETAW, &setterm);
X		break;
X
X	}
X}
X
X
X/*
X**	chat() - handle expect/send sequence to Device
X**
X**	Returns FAIL if an error occurs.
X*/
X
Xint
Xchat(s)
Xchar *s;
X{
X	register int state = EXPECT;
X	boolean finished = FALSE, if_fail = FALSE;
X	char c, *p;
X	char word[MAXLINE+1];		/* buffer for next word */
X
X	debug3(D_INIT, "chat(%s) called\n", s);
X
X	while (!finished) {
X		p = word;
X		while (((c = (*s++ & 0177)) != '\0') && c != ' ' && c != '-')
X			*p++ = (c) ? c : '\177';
X		if (c == '\0')
X			finished = TRUE;
X		if (c == '-')
X			if_fail = (if_fail == FALSE) ? TRUE : FALSE;
X		*p = '\0';
X		switch (state) {
X		case EXPECT:
X			if (expect(word) == FAIL) {
X				if (if_fail == FALSE)
X					return(FAIL);	/* no if-fail seq */
X			} else {
X				/* eat up rest of current sequence
X				 */
X				if (if_fail == TRUE) {
X					while ((c = (*s++ & 0177)) != '\0' &&
X						c != ' ')
X						;
X					if (c == '\0')
X						finished = TRUE;
X				}
X			}
X			state = SEND;
X			break;
X		case SEND:
X			if (send(word) == FAIL)
X				return(FAIL);
X			state = EXPECT;
X			break;
X		}
X		continue;
X	}
X	debug2(D_INIT, "chat() successful\n");
X	return (SUCCESS);
X}
X
X
X/*
X**	unquote() - decode char(s) after a '\' is found.
X**
X**	Returns the pointer s; decoded char in *c.
X*/
X
Xchar	valid_oct[] = "01234567";
Xchar	valid_dec[] = "0123456789";
Xchar	valid_hex[] = "0123456789aAbBcCdDeEfF";
X
Xchar *
Xunquote(s, c)
Xchar *s, *c;
X{
X	int value, base;
X	char n, *valid;
X
X	n = *s++;
X	switch (n) {
X	case 'b':
X		*c = '\b';	break;
X	case 'c':
X		if ((n = *s++) == '\n')
X			*c = '\0';
X		else
X			*c = n;
X		break;
X	case 'f':
X		*c = '\f';	break;
X	case 'n':
X		*c = '\n';	break;
X	case 'r':
X		*c = '\r';	break;
X	case 's':
X		*c = ' ';	break;
X	case 't':
X		*c = '\t';	break;
X	case '\n':
X		*c = '\0';	break;	/* ignore NL which follows a '\' */
X	case '\\':
X		*c = '\\';	break;	/* '\\' will give a single '\' */
X	default:
X		if (isdigit(n)) {
X			value = 0;
X			if (n == '0') {
X				if (*s == 'x') {
X					valid = valid_hex;
X					base = 16;
X					s++;
X				} else {
X					valid = valid_oct;
X					base = 8;
X				}
X			} else {
X				valid = valid_dec;
X				base = 10;
X				s--;
X			}
X			while (strpbrk(s, valid) == s) {
X				value = (value * base) + (int) (n - '0');
X				s++;
X			}
X			*c = (char) (value & 0377);
X		} else {
X			*c = n;
X		}
X		break;
X	}
X	return(s);
X}
X
X
X/*
X**	send() - send a string to stdout
X*/
X
Xint
Xsend(s)
Xregister char *s;
X{
X	register int retval = SUCCESS;
X	char ch;
X
X	debug2(D_INIT, "SEND: (");
X
X	if (strequal(s, "\"\"")) {	/* ("") used as a place holder */
X		debug2(D_INIT, "[nothing])\n");
X		return(retval);
X	}
X
X	while (ch = *s++) {
X		if (ch == '\\') {
X			switch (*s) {
X			case 'p':		/* '\p' == pause */
X				debug2(D_INIT, "[pause]");
X				(void) sleep(1);
X				s++;
X				continue;
X			case 'd':		/* '\d' == delay */
X				debug2(D_INIT, "[delay]");
X				(void) sleep(2);
X				s++;
X				continue;
X			case 'K':		/* '\K' == BREAK */
X				debug2(D_INIT, "[break]");
X				(void) ioctl(STDOUT, TCSBRK, 0);
X				s++;
X				continue;
X			default:
X				s = unquote(s, &ch);
X				break;
X			}
X		}
X		debug3(D_INIT, ((ch < ' ') ? "^%c" : "%c"),
X			       ((ch < ' ') ? ch | 0100 : ch));
X		if (write(STDOUT, &ch, 1) == FAIL) {
X			retval = FAIL;
X			break;
X		}
X	}
X	debug3(D_INIT, ") -- %s\n", (retval == SUCCESS) ? "OK" : "Failed");
X	return(retval);
X}
X
X
X/*
X**	expect() - look for a specific string on stdin
X*/
X
Xjmp_buf env;	/* here so expalarm() sees it */
X
Xint
Xexpect(s)
Xregister char *s;
X{
X	register int i;
X	register int expfail = EXPFAIL;
X	register retval = FAIL;
X	char ch, *p, word[MAXLINE+1], buf[MAXBUF];
X	sig_t (*oldalarm)();
X
X	if (strequal(s, "\"\"")) {	/* ("") used as a place holder */
X		debug2(D_INIT, "EXPECT: ([nothing])\n");
X		return(SUCCESS);
X	}
X
X#ifdef	lint
X	/* shut lint up about 'warning: oldalarm may be used before set' */
X	oldalarm = signal(SIGALRM, SIG_DFL);
X#endif	/* lint */
X
X	/* look for escape chars in expected word
X	 */
X	for (p = word; ch = (*s++ & 0177);) {
X		if (ch == '\\') {
X			if (*s == 'A') {	/* spot for AutoBaud digits */
X				*p++ = AUTOBD;
X				s++;
X				continue;
X			} else if (*s == 'T') {	/* change expfail timeout */
X				if (isdigit(*++s)) {
X					s = unquote(s, &ch);
X					/* allow 3 - 255 second timeout */
X					if ((expfail = (int) ch) < 3)
X						expfail = 3;
X				}
X				continue;
X			} else
X				s = unquote(s, &ch);
X		}
X		*p++ = (ch) ? ch : '\177';
X	}
X	*p = '\0';
X
X	if (setjmp(env)) {	/* expalarm returns non-zero here */
X		debug3(D_INIT, "[timed out after %d seconds]\n", expfail);
X		(void) signal(SIGALRM, oldalarm);
X		return(FAIL);
X	}
X
X	oldalarm = signal(SIGALRM, expalarm);
X	(void) alarm((unsigned) expfail);
X
X	debug3(D_INIT, "EXPECT: <%d> (", expfail);
X	debug1(D_INIT, word);
X	debug2(D_INIT, "), GOT:\n");
X	p = buf;
X	while (read(STDIN, &ch, 1) == 1) {
X		debug3(D_INIT, ((ch < ' ') ? "^%c" : "%c"),
X			       ((ch < ' ') ? ch | 0100 : ch));
X		*p++ = (char) ((int) ch & 0177);
X		*p = '\0';
X		if (strlen(buf) >= strlen(word)) {
X			for (i=0; buf[i]; i++)
X				if (expmatch(&buf[i], word)) {
X					retval = SUCCESS;
X					break;
X				}
X		}
X		if (retval == SUCCESS)
X			break;
X	}
X	(void) alarm((unsigned) 0);
X	(void) signal(SIGALRM, oldalarm);
X	debug3(D_INIT, " -- %s\n", (retval == SUCCESS) ? "got it" : "Failed");
X	return(retval);
X}
X
X
X/*
X**	expmatch() - compares expected string with the one gotten
X*/
X
X#ifdef	TELEBIT
Xchar	valid[] = "0123456789FAST";
X#else	/* TELEBIT */
Xchar	valid[] = "0123456789";
X#endif	/* TELEBIT */
X
Xboolean
Xexpmatch(got, exp)
Xregister char *got;
Xregister char *exp;
X{
X	register int ptr = 0;
X
X	while (*exp) {
X		if (*exp == AUTOBD) {	/* substitute real digits gotten */
X			while (*got && strpbrk(got, valid) == got) {
X				AutoBaud = TRUE;
X				if (ptr < (sizeof(AutoRate) - 2))
X					AutoRate[ptr++] = *got;
X				got++;
X			}
X			if (*got == '\0')
X				return(FALSE);	/* didn't get it all yet */
X			AutoRate[ptr] = '\0';
X			exp++;
X			continue;
X		}
X		if (*got++ != *exp++)
X			return(FALSE);		/* no match */
X	}
X	return(TRUE);
X}
X
X
X/*
X**	expalarm() - called when expect()'s SIGALRM goes off
X*/
X
Xsig_t
Xexpalarm()
X{
X	longjmp(env, 1);
X}
X
X
X/*
X**	getlogname() - get the users login response
X**
X**	Returns int value indicating success.
X*/
X
Xint
Xgetlogname(termio, name, size)
XTERMIO *termio;
Xregister char *name;
Xint size;
X{
X	register int count;
X	register int lower = 0;
X	register int upper = 0;
X	char ch, *p;
X	ushort lflag;
X
X#ifdef	MY_ERASE
X	char Erase = MY_ERASE;
X#else
X	char Erase = CERASE;
X#endif	/* MY_ERASE */
X#ifdef	MY_KILL
X	char Kill = MY_KILL;
X#else
X	char Kill = CKILL;
X#endif	/* MY_KILL */
X
X	debug2(D_GETL, "getlogname() called\n");
X
X	(void) ioctl(STDIN, TCGETA, termio);
X	lflag = termio->c_lflag;
X
X	termio->c_iflag = 0;
X	termio->c_oflag = 0;
X	termio->c_cflag = 0;
X	termio->c_lflag = 0;
X
X	p = name;	/* point to beginning of buffer */
X	count = 0;	/* nothing entered yet */
X
X	do {
X		if (read(STDIN, &ch, 1) != 1)	/* nobody home */
X			exit(0);
X		if ((ch = (char) ((int) ch & 0177)) == CEOF)
X			if (p == name)		/* ctrl-d was first char */
X				exit(0);
X		if (ch == CQUIT)		/* user wanted out, i guess */
X			exit(0);
X		if (ch == '\0') {
X			debug2(D_GETL, "returned (BADSPEED)\n");
X			return(BADSPEED);
X		}
X		if (!(lflag & ECHO)) {
X			(void) putc(ch, stdout);
X			(void) fflush(stdout);
X		}
X		if (ch == Erase) {
X			if (count) {
X				if (!(lflag & ECHOE)) {
X					(void) fputs(" \b", stdout);
X					(void) fflush(stdout);
X				}
X				--p;
X				--count;
X			}
X		} else if (ch == Kill) {
X			if (!(lflag & ECHOK)) {
X				(void) fputs("\r\n", stdout);
X				(void) fflush(stdout);
X			}
X			p = name;
X			count = 0;
X		} else {
X			*p++ = ch;
X			count++;
X			if (islower(ch))
X				lower++;
X			if (isupper(ch))
X				upper++;
X		}
X	} while ((ch != '\n') && (ch != '\r') && (count < size));
X
X	*(--p) = '\0';	/* terminate buffer */
X
X	if (ch == '\r') {
X		(void) putc('\n', stdout);
X		(void) fflush(stdout);
X		termio->c_iflag |= ICRNL;	/* turn on cr/nl xlate */
X		termio->c_oflag |= ONLCR;
X	} else if (ch == '\n') {
X		(void) putc('\r', stdout);
X		(void) fflush(stdout);
X	}
X
X	if (strlen(name) == 0) {
X		debug2(D_GETL, "returned (NONAME)\n");
X		return(NONAME);
X	}
X
X	if (upper && !lower) {
X#ifdef	WARNCASE
X		if (WarnCase) {
X			WarnCase = FALSE;
X			debug2(D_GETL, "returned (BADCASE)\n");
X			return(BADCASE);
X		}
X#endif	/* WARNCASE */
X		for (p=name; *p; p++)		/* make all chars UC */
X			*p = toupper(*p);
X		termio->c_iflag |= IUCLC;
X		termio->c_oflag |= OLCUC;
X		termio->c_lflag |= XCASE;
X	}
X
X	debug3(D_GETL, "returned (SUCCESS), name=(%s)\n", *name);
X	return(SUCCESS);
X}
X
X
X/*
X**	logerr() - display an error message
X*/
X
Xvoid
Xlogerr(msg)
Xregister char *msg;
X{
X	register FILE *co;
X	char *errdev;
X
X	errdev = (Check) ? "/dev/tty" : CONSOLE;
X
X	if ((co = fopen(errdev, "w")) != (FILE *) NULL) {
X		(void) fprintf(co, "\r\n%s (%s): %s\r\n", MyName, Device, msg);
X		(void) fclose(co);
X	}
X
X#ifdef	TRYMAIL
X	else {
X		char buf[MAXLINE];
X		FILE *popen();
X
X		(void) sprintf(buf, "%s %s", MAILER, NOTIFY);
X		if ((co = popen(buf, "w")) != (FILE *) NULL) {
X			(void) fprintf(co, "To: %s\n", NOTIFY);
X			(void) fprintf(co, "Subject: %s problem\n\n", MyName);
X			(void) fprintf(co, "%s: %s\n", Device, msg);
X			(void) pclose(co);
X		}
X	}
X#endif	/* TRYMAIL */
X
X}
X
X
X#ifdef	DEBUG
X
X/*
X**	debug() - an fprintf to the debug file
X**
X**	Only does the output if the requested level is "set."
X*/
X
X#ifdef	VARARGS
X
X#include <varargs.h>
X
X/*VARARGS2*/
Xvoid
Xdebug(lvl, fmt, va_alist)
Xint lvl;
Xchar *fmt;
Xva_dcl
X{
X	va_list args;
X
X	va_start(args);
X	if (Debug & lvl) {
X		(void) vfprintf(Dfp, fmt, args);
X		(void) fflush(Dfp);
X	}
X	va_end(args);
X}
X
X#else	/* VARARGS */
X
X/*VARARGS2*/
Xvoid
Xdebug(lvl, fmt, arg1, arg2, arg3, arg4)
Xint lvl;
Xchar *fmt;
X{
X	if (Debug & lvl) {
X		(void) fprintf(Dfp, fmt, arg1, arg2, arg3, arg4);
X		(void) fflush(Dfp);
X	}
X}
X
X#endif	/* VARARGS */
X
X/*
X**	dprint() - like debug(), but shows control chars
X*/
X
Xvoid
Xdprint(lvl, word)
Xint lvl;
Xchar *word;
X{
X	char *p, *fmt, ch;
X
X	if (Debug & lvl) {
X		p = word;
X		while (ch = *p++) {
X			if (ch == AUTOBD) {
X				(void) fputs("[speed]", Dfp);
X				(void) fflush(Dfp);
X				continue;
X			} else if (ch < ' ') {
X				fmt = "^%c";
X				ch = ch | 0100;
X			} else {
X				fmt = "%c";
X			}
X			(void) fprintf(Dfp, fmt, ch);
X		}
X		(void) fflush(Dfp);
X	}
X}
X
X#endif	/* DEBUG */
X
X
X/* end of funcs.c */
!STUFFY!FUNK!
echo Extracting defaults.c
sed >defaults.c <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: defaults.c,v 2.0 90/09/19 19:42:09 paul Rel $
X**
X**	Routines to access runtime defaults file.
X**	This is to allow program features to be configured
X**	without the need to recompile.
X**
X**	XENIX has defopen(S) and defread(S), but I think this is better,
X**	since it reads the file only once, storing the values in core.
X**	It is certainly more portable.
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
X**	$Log:	defaults.c,v $
X**	Revision 2.0  90/09/19  19:42:09  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X#include "getty.h"
X#include "defaults.h"
X#include <sys/stat.h>
X#include <errno.h>
X
X#if defined(RCSID) && !defined(lint)
Xstatic char *RcsId =
X"@(#)$Id: defaults.c,v 2.0 90/09/19 19:42:09 paul Rel $";
X#endif
X
X#ifndef DEFAULTS
X#define DEFAULTS  "/etc/default/%s"	/* location of defaults file */
X#endif	/* DEFAULTS */
X
X#ifndef	MAXLINE
X#define	MAXLINE	256	/* maximum # chars in a line */
X#endif	/* MAXLINE */
X
X#ifndef MAXDEF
X#define MAXDEF  100	/* maximum # of lines in defaults file */
X#endif	/* MAXDEF */
X
X
X/*
X**	defbuild() - create in-core list of defaults
X**
X**	Returns (DEF**)NULL if no defaults file found or an error occurs.
X*/
X
XDEF **
Xdefbuild(filename)
Xchar *filename;
X{
X	register int i;
X	register DEF *dp;
X	register DEF *next;
X	FILE *fp;
X	char *fname, defname[MAXLINE+1], buf[MAXLINE+1];
X	static DEF *deflist[MAXDEF+1];		/* in-core list */
X	struct stat st;
X	extern int errno;
X
X	debug3(D_DEF, "defbuild(%s) called\n",
X			((filename == (char *) NULL) ? "NULL" : filename));
X
X	/* look to see if there's a DEFAULTS/MyName.Device file
X	 */
X	(void) sprintf(buf, "%s", DEFAULTS);
X	(void) strcat(buf, ".%s");
X	(void) sprintf(defname, buf, MyName, Device);
X	debug3(D_DEF, "looking for %s\n", defname);
X	if ((stat(defname, &st) == FAIL) && errno == ENOENT) {	/* Nope */
X		debug2(D_DEF, "stat failed, no file\n");
X		(void) sprintf(defname, DEFAULTS, MyName);
X	}
X
X	fname = (filename != (char *) NULL) ? filename : defname;
X
X	/* if fname doesn't begin with a '/', assume it's a
X	 * filename to be made "DEFAULTS/fname"
X	 */
X	if (*fname != '/') {
X		(void) sprintf(defname, DEFAULTS, fname);
X		fname = defname;
X	}
X
X	debug3(D_DEF, "fname = (%s)\n", fname);
X
X	if ((fp = defopen(fname)) == (FILE *) NULL) {
X		debug2(D_DEF, "defopen() failed\n");
X		return((DEF **) NULL);		/* couldn't open file */
X	}
X
X	for (i=0; i < MAXDEF; i++) {
X		if ((dp = defread(fp)) == (DEF *) NULL)
X			break;
X		if ((next = (DEF *) malloc((unsigned) sizeof(DEF))) ==
X		    (DEF *) NULL) {
X			logerr("malloc() failed: defaults list truncated");
X			break;
X		}
X		next->name = dp->name;
X		next->value = dp->value;
X		deflist[i] = next;
X		debug5(D_DEF, "deflist[%d]: name=(%s), value=(%s)\n",
X				i, deflist[i]->name, deflist[i]->value);
X	}
X	deflist[i] = (DEF *) NULL;	/* terminate list */
X	(void) defclose(fp);
X	debug2(D_DEF, "defbuild() successful\n");
X	return(deflist);
X}
X
X
X/*
X**	defvalue() - locate the value in "deflist" that matches "name"
X**
X**	Returns (char*)NULL if no match is made.
X*/
X
Xchar *
Xdefvalue(deflist, name)
Xregister DEF **deflist;
Xregister char *name;
X{
X	debug3(D_DEF, "defvalue(%s) called\n", name);
X
X	if (deflist != (DEF **) NULL)
X		for (; *deflist != (DEF *) NULL; *deflist++)
X			if (strequal(name, (*deflist)->name)) {
X				debug3(D_DEF, "defvalue returns (%s)\n",
X						(*deflist)->value);
X				return((*deflist)->value);  /* normal exit */
X			}
X
X	debug2(D_DEF, "defvalue returns NULL\n");
X	return((char *) NULL);
X}
X
X
X/*
X**	defopen() - open the defaults file
X**
X**	Returns (FILE*)NULL if file not found or an error occurs.
X*/
X
XFILE *
Xdefopen(filename)
Xregister char *filename;
X{
X	if (filename != (char *) NULL)
X		return(fopen(filename, "r"));
X
X	return((FILE *) NULL);
X}
X
X
X/*
X**	defread() - read a line from the defaults file
X**
X**	Returns (DEF*)NULL if an error occurs.
X*/
X
XDEF *
Xdefread(fp)
Xregister FILE *fp;
X{
X	register char *p;
X	STDCHAR buf[MAXLINE+1];	/* buffer large enough for 1 line */
X	static DEF def;
X
X	do {
X		if (fgets(buf, sizeof(buf), fp) == (char *) NULL)
X			return((DEF *) NULL);	/* no more lines */
X
X	} while (buf[0] == '#');		/* ignore comment lines */
X
X	buf[strlen(buf)-1] = '\0';		/* rm trailing \n */
X
X	/* lines should be in the form "NAME=value"
X	 */
X	if ((p = index(buf, '=')) == (char *) NULL) {
X		(void) sprintf(MsgBuf, "bad defaults line: %s", buf);
X		logerr(MsgBuf);
X		return((DEF *) NULL);
X	}
X	*p++ = '\0';		/* split into two fields, name and value */
X	def.name = strdup(buf);
X	def.value = strdup(p);
X
X	return(&def);
X}
X
X
X/*
X**	defclose() - closes the defaults file
X**
X**	Returns EOF if an error occurs.
X*/
X
Xint
Xdefclose(fp)
Xregister FILE *fp;
X{
X	return(fclose(fp));
X}
X
X
X/* end of defaults.c */
!STUFFY!FUNK!
echo Extracting extern.h
sed >extern.h <<'!STUFFY!FUNK!' -e 's/X//'
X/*
X**	$Id: extern.h,v 2.0 90/09/19 19:48:33 paul Rel $
X**
X**	Defines all external values.
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
X**	$Log:	extern.h,v $
X**	Revision 2.0  90/09/19  19:48:33  paul
X**	Initial 2.0 release
X**	
X*/
X
X
X#ifdef	MAIN			/* define as "extern", except for MAIN,	*/
X#define EXTERN			/* which is defined only in main.c	*/
X#else
X#define EXTERN	extern
X#endif	/* MAIN */
X
X
X/*	Global variables
X */
X
X#ifdef	MAIN
XEXTERN	STDCHAR	MsgBuf[80];	/* message buffer */
X#else
XEXTERN	STDCHAR	MsgBuf[];
X#endif	/* MAIN */
X
XEXTERN	boolean	AutoBaud;	/* autobauding requested? */
XEXTERN	char	AutoRate[16];	/* AutoBaud digits buffer */
XEXTERN	boolean	Check;		/* check a gettytab file? */
XEXTERN	char	*CheckFile;	/* gettytab-like file to check */
XEXTERN	char	*Device;	/* controlling line (minus "/dev/") */
XEXTERN	char	*GtabId;	/* current gettytab id */
XEXTERN	boolean	NoHangUp;	/* don't hangup line before setting speed */
XEXTERN	char	*LineD;		/* line discipline */
XEXTERN	char	*MyName;	/* this program name */
XEXTERN	int	Nusers;		/* number of users currently logged in */
XEXTERN	char	*Speed;		/* current baud rate (string literal) */
XEXTERN	char	*SysName;	/* nodename of system */
XEXTERN	int	TimeOut;	/* timeout value from command line */
XEXTERN	char	*Version;	/* value of VERSION */
X
X#ifdef	WARNCASE
XEXTERN	boolean	WarnCase;	/* controls display of bad case message */
X#endif	/* WARNCASE */
X
X#ifdef	DEBUG
XEXTERN	int	Debug;		/* debug value from command line */
XEXTERN	FILE	*Dfp;		/* debug output file pointer */
X#endif	/* DEBUG */
X
X
X/*	System routines
X */
X
Xextern	int	fputc();
Xextern	char	*malloc(), *ttyname();
Xextern	unsigned alarm(), sleep();
Xextern	time_t	time();
X
X#ifndef	STRDUP			/* Is There In Truth No Strdup() ? */
Xextern	char	*strdup();
X#endif	/* STRDUP */
X
X#ifndef	GETUTENT		/* How about getutent() ? */
Xextern	struct utmp	*getutent();
Xextern	void		setutent(), endutent();
X#endif	/* GETUTENT */
X
X#ifndef	PUTENV			/* putenv() ? */
Xextern	int	putenv();
X#endif	/* PUTENV */
X
X
X/* end of extern.h */
!STUFFY!FUNK!
echo Extracting patchlevel.h
sed >patchlevel.h <<'!STUFFY!FUNK!' -e 's/X//'
X#define PATCHLEVEL 0
!STUFFY!FUNK!
echo ""
echo "End of kit 3 (of 5)"
cat /dev/null >kit3isdone
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
