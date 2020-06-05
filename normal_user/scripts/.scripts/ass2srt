#!/usr/bin/perl -w
# http://code.google.com/p/ass2srt/
use strict;
use warnings;
use encoding 'utf-8';
use Getopt::Long;
use File::Spec;

Getopt::Long::Configure( "pass_through", "no_ignore_case" );

# Default encoding
my $defaultEnc  = 'utf8';
my $fromEnc     = '';
my $toEnc       = '';
my $help        = 0;
my $preserve    = 0;
my $showVer     = 0;
my $showLicense = 0;
my $dosFormat   = 0;
my $macFormat   = 0;

my $oldTime = "";

$fromEnc = $ENV{'ASS2SRT_FROM'};
$toEnc   = $ENV{'ASS2SRT_TO'};

my $DEBUG = 0;
my $noCorrect = 0;

GetOptions(
    "help|h",     \$help,      "from|f=s",    \$fromEnc,
    "to|t=s",     \$toEnc,     "default|d=s", \$defaultEnc,
    "preserve|p", \$preserve,
    "version|v",  \$showVer,   "dos|o",       \$dosFormat,
    "mac|m",      \$macFormat, "license|l",   \$showLicense,
    "debug",      \$DEBUG,     "nocorrect",   \$noCorrect
);


# Lines read from .ass file will be put here (each in a hash with the
# relevant info) to be written to the .srt file after some post-processing.
my @lines;

# Wrap format
my $crlf = "\n";

# If the specified output at the same time as Mac and DOS format, 
# responding to an error message and terminated
( $dosFormat && $macFormat )
    && die( "\n Error: \n\tOption -m|--mac and -o|--dos can not exist together \n" );

if ($dosFormat) { $crlf = "\r" . $crlf; }
if ($macFormat) { $crlf = "\r"; }

# Program version
my $version = "0.3.0.1";

# Display help message
if ($help) { usage(); }

# Show license information
if ($showLicense) { license(); }

# Show version Information
if ($showVer) { showVersion(); }

# If the source file encoding is not specified, then set it equals to defaultEnc
if ( !$fromEnc ) { $fromEnc = $defaultEnc; }

# If the purpose file encoding is not specified, then set it equals to defaultEnc
if ( !$toEnc ) { $toEnc = $defaultEnc; }

# The .ass file file name
my $assFile = shift || '';
if ( !$assFile ) { usage(); }

# The .srt file file name, the default value is .ass's filename, 
# but changed the name extension to .srt
my $srtFile = shift || '';
if ( !$srtFile ) {
    $srtFile = $assFile;
    $srtFile =~ s|.[^.]*$||;
    $srtFile .= ".srt";
}

# Using the parameters listed
print "Using parameters: \n";
print "\t .ass File Encoding: $fromEnc\n";
print "\t .SRT File Encoding: $toEnc\n";
print "\n";

# Open file
open( ASSFILE, "<", $assFile )
    or die 'Can not open ".ass" source file:' . $assFile . ", please check it!!\n";

# Specify the file encoding
binmode( ASSFILE, ':encoding(' . $fromEnc . ')' );

# Check the existence of the system environment variable OS (Windows OS should be set this)
my $OS_TYPE = $ENV{'OS'};
 
# Assigned the .srt file encodings
my $toEncString = ':encoding(' . $toEnc . ')';

# Depending on OS type (only for Windows), fix the .srt file encoding setting.
if ( $OS_TYPE && $OS_TYPE =~ m/windows/i ) {
    print "Operation System is: " . $OS_TYPE
        . ", Checking File Encoding... \n";

    # Only use UTF16 or UCS format when otherwise specified (others need another test)
    if ( ( $toEnc =~ m/utf16/i ) || ( $toEnc =~ m/ucs/i ) ) {
        $toEncString = ':raw' . $toEncString;
    }
}

# Unicode output file on Windows need to join the BOM identification mark.
if ( $toEncString =~ m/:raw/i ) {
    print SRTFILE "\x{FEFF}";
    print "Using unicode encoding, print BOM signature to file: " . $srtFile
        . "\n\n";
}

# Number of records subtitles
my $lineNum = 0;

# Read .ass and deal with the source file
while (<ASSFILE>) {
    chomp;

    # If a line begin with 'Dialougue', extract this line's parameters
    if (m/^Dialogue:/) {
        $lineNum = extractLine( $lineNum, $_ );
     }
    elsif (m/^(Title:|Original)/) {
	 # If a line begins with 'Title' or 'Original', it is the source for the subtitles
        print $_ . "\n";
     }

}

# Close the file
close ASSFILE;


# post-process lines to remove errors.
if (!$noCorrect)
{
    for (my $i = 0; $i < scalar @lines; $i++)
    {
        my $line = $lines[$i];
        my $prevLine = undef;
        $prevLine = $lines[$i-1] if $i > 0;

        # if the begin of the previous line is the same as the begin of this line,
        # merge the two lines.
        if ($prevLine && $prevLine->{begin} eq $line->{begin})
        {
            # merge subtitles
            $prevLine->{subtitle} .= "\n" . $line->{subtitle};

            # remove line $i from the list
            @lines = (@lines[0..$i-1], @lines[$i+1..$#lines]);

            # resync things for next test
            $i--;
            $prevLine = undef;
            $prevLine = $lines[$i-1] if $i > 0;
        }

        # if the end of the previous line is smaller than the begin of this line,
        # change the end of the previous line to be the begin of this line.
        if ($prevLine && $prevLine->{end} gt $line->{begin})
        {
            $prevLine->{end} = $line->{begin};
        }
    }
}


open( SRTFILE, ">", $srtFile )
    or die 'Can not open the ".srt" purpose of file:' . $srtFile . ", please check!\n";

# Specified file used to write code
binmode( SRTFILE, $toEncString );

# Write SRT file.
my $lineNumber = 1;
foreach my $line (@lines)
{
    # Write .srt file
    # Because .ass unit of time (10ms) different with .srt (1ms), so the full complement of 0
    my $currentTime = $line->{begin} . "0 --> " . $line->{end} . "0";

    print SRTFILE $lineNumber . $crlf;
    print SRTFILE $currentTime . $crlf;
    print SRTFILE $line->{subtitle} . " " . $crlf . $crlf . $crlf;

    $lineNumber++;
}

close SRTFILE;


# Extract data for one line in the .ass file
sub extractLine {

    # Deal with the number of rows
    # From. ass of the original content
    my ($lineNumber, $content) = @_;

    my $begin;
    my $end;
    my $subtitle;
    my $currentTime;

    # Solved starting time, ending time, subtitle format, subtitles content
    if ( $content
        =~ m/Dialogue: [^,]*,([^,]*),([^,]*),([^,]*),[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,(.*)$/
        )
    {
        $begin    = $1;
        $end      = $2;
        $subtitle = $4;

        my $isComment = $3;

        print "\nLine: $lineNumber\n  Begin: [$begin]  End: [$end]  isComment: [$isComment]\n  Subtitle: [$subtitle]\n"
            if $DEBUG;

        # the separator between seconds and ms is "," -- not ".", so we change it !
        $begin =~ s/\./,/g;
        $end   =~ s/\./,/g;

        # If the time format will not be part of the hour when the two chars, make up two chars.
        if ( $begin =~ m/^\d{1}:/ ) {
            $begin = "0" . $begin;
          }

        if ( $end =~ m/^\d{1}:/ ) {
            $end = "0" . $end;
          }

        # First filter out the end of every title to the digital sign in order to follow-up to the output under a variety of formats on different platforms
        $subtitle =~ s/\r$//g;

        # If there is no such setting .ass control commands, then filter out the
        if ( !$preserve ) {
            $subtitle =~ s/{[^}]*}//g;
        }

        # Comment if the subtitle format, then in the before and after the add ()
        if ( $isComment eq 'comment' ) {
            $subtitle = '(' . $subtitle . ')';
        }

        print "\nAfter:\n  Begin: [$begin]  End: [$end]  isComment: [$isComment]\n  Subtitle: [$subtitle]\n"
            if $DEBUG;

        my %line = ( begin => $begin, end => $end, isComment => $isComment, subtitle => $subtitle );
        push @lines, \%line;

        return $lineNumber;
    }
}

# Use
sub usage {
    print <<__HELP__;

ass2srt [option] .ass source files [.srt purpose of file]

    The Advanced SubStation Alpha ".ass" file format to SubRip ".srt" format.

Options:
  -h --help               help show this help message

  -d, --default=encoding  default = encoding set the default file encoding, which is the purpose of the source file and use the same code file.
                          The default value is UTF-8 encoding format.

  -f, --from=encoding    from = encoding specified source file. ass coding system used. The set will be covered by the aforementioned pre -
                           Coding based on the settings file, when not specified the default file encoding for the default value.
                         * Tip: You can also use the system environment variables specified ASS2SRT_FROM

  -t, --to=encoding       encoding file specified purposes. srt coding system used. The set will be covered by the aforementioned pre -
                           Coding based on the settings file, when not specified the default file encoding for the default value.
                         * Tip: You can also use the system environment variables specified ASS2SRT_TO

  -p, --preserve          preserve the source file to retain. ass subtitles in the control instructions, write together. srt file.

  -o, --dos               dos specified output file format for DOS (the default format for Unix)
                        * Warning: can not be set this option with -m/--mac together.

  -m, --mac               mac specify the output file format for the Mac (the default format for Unix)
                        * Warning: can not be this option with set -o/--dos together.

  --debug                 print debugging output for each line of the .ass file read.

  --nocorrect             don't attempt to correct errors in subtitles
                        if not specified, corrections will be made for the following errors:
                          - subtitle i+1 begins before subtitle i ends - subtitle i's end will be set to subtitle i+1's begin
                          - subtitle i+1 begins at the same time as subtitle i begins - subtitles will be merged into one subtitle

.ass source file:
    The Subtitles of the original file.
    It can be Advanced SubStation Alpha (.ass) or SubStation Alpha (.ssa) format.

[.srt purpose file]:
    The default SubRip format output filename, the default value is the same as 
    the .ass source filename but it's extension changed to .srt.

Operation Example:

  Like iconv utility, use -f to specified from encoding set, the -t to specified target encoding set.

   1. Convert a utf16-le.ass file encoded with Unicode/UTF-18 LE to big5.srt with Big5 encoding.

       myhost  \$ perl ass2srt.pl -f utf16-le -t big5 utf16-le.ass big5.srt

   2. Convert a Big5 encoding .ass file to UTF-8 encoding .srt file

       myhost  \$ perl ass2srt.pl -f big5 -t utf8 big5.ass utf8.srt

   3. Convert a UTF-8 encoding .ass file to UTF-8 encoding .srt file, 
      no -f or -t parameter because UTF-8 is the default encoding setting.

       myhost  \$ perl ass2srt.pl utf-8.ass utf-8.srt

   4. Convert a UCS-2 LE encoding .ass file to UCS-2 LE encoding .srt file,
      UCS-2 LE is the same as Unicode encoding on Windows Platform.

       myhost  \$ perl ass2srt.pl -f ucs-2le -t ucs-2le ucs-2le.ass ucs-2le.srt

   5. Using the environment variables to specified encoding parameter
      * Warning: Some operation system can not add " or ' quotation marks to the varialbe's value

       myhost  \$ export ASS2SRT_FROM = utf16-le
       myhost  \$ export ASS2SRT_TO = big5
       myhost  \$ perl ass2srt.pl utf16-le.ass big5.srt

__HELP__
    exit 2;
}

# Show version of the message
sub showVersion {

    print <<__VERSION__;

ass2srt $version - Convert subtitles from .ass to .srt format

  Advanced SubStation Alpha subtitle file format conversion tool
  (c) 2006 Ada Hsu, hungwei.hsu (at) gmail (dot) com
  (c) 2009 Jean-Sebastien Guay, jean_seb (at) videotron (dot) ca

__VERSION__
    exit 2;
}

# License
sub license {

    print <<__LICENSE__;

  ass2srt $version - Convert subtitles from .ass to .srt format

  Advanced SubStation Alpha subtitle file format conversion tool
  (c) 2006 Ada Hsu, hungwei.hsu (at) gmail (dot) com
  (c) 2009 Jean-Sebastien Guay, jean_seb (at) videotron (dot) ca

   This utility use of the software CC-GNU GPL (http://creativecommons.org/licenses/GPL/2.0/) 
   authorization, You can view the relevant provisions of 
   http://www.gnu.org/copyleft/gpl.html text.

   You are free to use the software, but software maintainer will hold no liability for any damages,
   Thank You.

__LICENSE__
    exit 2;

}
