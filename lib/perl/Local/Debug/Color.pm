#!/usr/bin/perl

package Local::Debug::Color;

use strict;
use warnings;
use version; our $VERSION = qv(0.01);
use Pod::Usage;
use Pod::Man;
use Getopt::Long;
use Fatal qw( open close );
use Carp;
use English qw( -no_match_vars );
use Exporter qw( import );
use Term::ANSIColor;

our @EXPORT_OK = qw( msg debug );

if (caller) {
    return 1;
}
else {
    run();
}

##############################################################################
# Main program loop
sub run {
    my %opts;    # Runtime Options

    parse_runtime_options( \%opts );

    return;
}

##############################################################################
# Subroutines

##############################################################################
# Usage         : msg( bool, $message )
# Purpose       : Output a colorized string if bool is true
# Returns       : None
# Parameters    : Boolean containing the level, scalar containing the message
# Throws        : None
# Comments      : An alternate option was to have each caller "set" the level
#                   for itself in a hash stored in this module.  Then
#                   whenever the caller executed msg (or debug) the level for
#                   the caller would be looked up in the hash.  If the level
#                   is > 0 then the message would be printed.  This would
#                   save the caller from storing the level and specifying it
#                   on the msg() line.  But a hash lookup is slower than
#                   scalar, so having the caller store the level is faster.
# See Also      : debug()
sub msg {
    my $level = shift;
    if ($level) {
        my $message     = shift;
        my $calling_pkg = caller;
        print colored( "[$calling_pkg] <MSG> $message", 'cyan' ), "\n"
            or croak "Failed to print verbose message.\n";
    }
    return;
}

##############################################################################
# Usage         : debug( bool, $message )
# Purpose       : Print a colorized string if bool is true
# Returns       : None
# Parameters    : Boolean containing the level, scalar containing the message
# Throws        : None
# Comments      : None
# See Also      : msg()
sub debug {
    my $level = shift;
    if ($level) {
        my $message     = shift;
        my $calling_pkg = caller;
        print colored( "[$calling_pkg] <DEBUG> $message", 'yellow' ), "\n"
            or croak "Failed to print debug message.\n";
    }
    return;
}

##############################################################################
# Usage         : parse_runtime_options( \%opts );
# Purpose       : Parses the runtime options, performs checks for needed
#                   options, sets the verbosity level.
# Returns       : none
# Parameters    : \%opts - A reference to a hash
# Throws        : none
# Comments      : none
# See Also      : none
sub parse_runtime_options {
    my $opts_ref = shift;

    $opts_ref->{'verbose'} = 0;    # Set a default verbosity level
    $opts_ref->{'debug'}   = 0;    # Set a default debugging level

    # Get the command line options
    GetOptions( $opts_ref, 'help|?', 'man', 'writeman=i', 'verbose', 'debug' )
        or pod2usage(2);

    # Print the help page
    if ( exists $opts_ref->{'help'} ) {
        pod2usage(1);
    }

    # Write out the man page to the specified section
    if ( exists $opts_ref->{'writeman'} ) {
        my $parser = Pod::Man->new( section => $opts_ref->{'writeman'} );
        $parser->parse_from_file( $PROGRAM_NAME,
            "$PROGRAM_NAME.$opts_ref->{'writeman'}" );
    }

    # Print out the man page
    if ( exists $opts_ref->{'man'} ) {
        pod2usage( -exitval => 0, -verbose => 2 );
    }

    # Set verbosity
    msg( $opts_ref->{'verbose'}, 'Messages enabled.' );
    debug( $opts_ref->{'debug'}, 'Debugging enabled.' );

    return;
}

__END__

=head1 NAME

Local::Debug::Color.pm - Functions to print out color verbose and debug
messages.

=head1 VERSION

This documentation refers to Local::Debug::Color.pm version 0.01

=head1 USAGE

use Local::Debug::Color qw( msg debug );
my $VERBOSE = 1;
my $DEBUG = 0;
msg( $VERBOSE, 'This verbose message is printed.' );
debug( $DEBUG, 'This debug message is not printed.' );

=head1 REQUIRED ARGUMENTS

None

=head1 SYNOPSIS

Local::Debug::Color.pm [options]

  Options:
    -help|?               brief help message
    -man                  full documentation
    -writeman=i           write out a manpage
    -verbose              print out verbose messages
    -debug                print out debug messages

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=item B<-writeman>

Specify the manpage section and then write out the manpage to the current
directory as SCRIPTNAME.*

=item B<-verbose>

Print out verbose messages.

=item B<-debug>

Print out debug messages.

=back

=head1 DESCRIPTION

B<Local::Debug::Color.pm> provides functions to print out verbose and debug
messages.  Also colorizes the message based according to type.

=head1 DIAGNOSTICS

None

=head1 EXIT STATUS

None

=head1 CONFIGURATION

None

=head1 DEPENDENCIES

strict - Perl Distribution
warnings - Perl Distribution
Pod::Usage - Perl Distribution
Pod::Man - Perl Distribution
Getopt::Long - Perl Distribution
Fatal - Perl Distribution
Carp - Perl Distribution
English - Perl Distribution

=head1 INCOMPATIBILITIES

None

=head1 BUGS AND LIMITATIONS

There are no known bugs in the module.
Please report problems to Alex Dioso (alex.dioso@ikaika.org)
Patches are welcome.

=head1 AUTHOR

Alex Dioso (alex.dioso@ikaika.org)

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Alex Dioso (alex.dioso@ikaika.org).  All rights
reserved.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


=cut
