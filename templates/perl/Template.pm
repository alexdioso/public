#!/usr/bin/perl

package main;

#package Local::Foo;

use strict;
use warnings;
use version; our $VERSION = qv(0.01);
use Pod::Usage;
use Pod::Man;
use Getopt::Long;
use Fatal qw( open close );
use Carp;
use English qw( -no_match_vars );
use Data::Dumper;

use lib "$ENV{'HOME'}/git/perl";

use Local::Debug::Color qw( msg debug );

my $VERBOSE = 0;
my $DEBUG   = 0;

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
    GetOptions( $opts_ref, 'help|?', 'man', 'writeman=i', 'verbose', 'debug',
        'defaults' )
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
        pod2usage( -exit => 0, -verbose => 2 );
    }

    # Print out the defaults
    if ( exists $opts_ref->{'defaults'} ) {
        pod2usage(
            -exitval => 0,
            -verbose => 0,
            -message => Dumper($opts_ref)
        );
    }

    # Required arguments
    for my $option (qw{ }) {
        if ( not exists $opts_ref->{$option} ) {
            pod2usage(
                -exitval => 1,
                -verbose => 0,
                -message => "Option --$option is required."
            );
        }
    }

    # Set verbosity
    $VERBOSE = $opts_ref->{'verbose'};
    msg( $VERBOSE, 'Messages enabled.' );
    $DEBUG = $opts_ref->{'debug'};
    debug( $DEBUG, 'Debugging enabled.' );

    return;
}

__END__

=head1 NAME

TODO
Template.pm - This is a perl template.

=head1 VERSION

TODO
This documentation refers to Template.pm version 0.01

=head1 USAGE

TODO
Brief usage examples.

=head1 REQUIRED ARGUMENTS

TODO
List of required arguments.

=head1 SYNOPSIS

TODO
Template.pm [options]

  Options:
    --help|?               brief help message
    --man                  full documentation
    --writeman=i           write out a manpage
    --verbose              print out verbose messages
    --debug                print out debug messages
    --defaults             print out the default values

=head1 OPTIONS

=over 8

=item B<--help>

Print a brief help message and exits.

=item B<--man>

Prints the manual page and exits.

=item B<--writeman>

Specify the manpage section and then write out the manpage to the current
directory as SCRIPTNAME.*

=item B<--verbose>

Print out verbose messages.

=item B<--debug>

Print out debug messages.

=item B<--defaults>

Print out the default values.

TODO

=back

=head1 DESCRIPTION

TODO
B<Template.pm> is just a perl template.  Fix your docs.

=head1 DIAGNOSTICS

TODO
List of every error and warning message that the application can generate,
with a full explanation of each problem, one or more likely causes, and any
suggested remedies.

=head1 EXIT STATUS

TODO
List of every exit status and what they mean.

=head1 CONFIGURATION

TODO
A full explanation of any configuration system(s) used by the application
including the names and locations of any configuration files, and the meaning
of any environment variables or properties that can be set.  These
descriptions must also include details of any configuration language used.

=head1 DEPENDENCIES

TODO
A list of all the other modules that this module relies upon, including any
restrictions on versions, and an indication of whether these required modules
are part of the standard Perl distribution, part of the module's
distribution, or must be installed separately.

perldoc perlmodlib

- Perl Distribution -
strict
warnings
Pod::Usage
Pod::Man
Getopt::Long
Fatal
Carp
English
Data::Dumper

- Local Distribution -
Local::Debug::Color

=head1 INCOMPATIBILITIES

TODO
A list of any modules that this module cannot be used in conjunction with.
This may be due to name conflicts in the interface, or competition for system
or program resources, or due to internal limitations of Perl.

=head1 BUGS AND LIMITATIONS

TODO
A list of known problems with the module, together with some indication of
whether they are likely to be fixed in an upcoming release.

Also a list of restrictions on the features the module does provide: data
types that cannot be handled, performance issues and the circumstances in
which they may arise, practical limitations on the size of data sets, special
cases that are not (yet) handled, etc.

The initial template usually just has:

There are no known bugs in the module.
Please report problems to <Maintainer name(s)> (<contact adress>)
Patches are welcome.

=head1 AUTHOR

TODO
<Author name(s)> (<contact address>)

=head1 LICENSE AND COPYRIGHT

TODO
Copyright <year> <copyright holder> (<contact address>).  All rights
reserved.

followed by whatever license you wish to release it under.

=cut
