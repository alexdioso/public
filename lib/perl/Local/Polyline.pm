#!/usr/bin/perl

package Local::Polyline;

use strict;
use warnings;
use version; our $VERSION = qv(0.01);
use Pod::Usage;
use Pod::Man;
use Getopt::Long;
use autodie qw( :all );
use Carp;
use English qw( -no_match_vars );

use Readonly;

Readonly my $OneE5 => 1e5;

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

    print encode( \@ARGV ) . "\n";

    return;
}

##############################################################################
# Subroutines

##############################################################################
# Usage         : encode()
# Purpose       : Encode the set of coordinates
# Returns       : Scalar with a string containing the encoded coordinates
# Parameters    : Array reference with the coordinates
# Throws        : None
# Comments      : None
# See Also      : None
sub encode {
    my $coordinates_ref = shift;

    my $encoded_string = q{};
    my $lat_e5         = 0;
    my $lon_e5         = 0;
    my $enc;

    for my $latlon ( @{$coordinates_ref} ) {
        $latlon =~ s/\s*//gxsm;
        my ( $lat, $lon ) = split /,/xsm, $latlon;
        ( $enc, $lat_e5 ) = encode_number( $lat, $lat_e5 );
        $encoded_string .= $enc;
        ( $enc, $lon_e5 ) = encode_number( $lon, $lon_e5 );
        $encoded_string .= $enc;
    }

    return $encoded_string;
}

##############################################################################
# Usage         : encode_number()
# Purpose       : Encode a number
# Returns       : Scalar with the encoded number and scalar with the E5
#                   calculation
# Parameters    : Scalar with the number to encode and scalar with the
#                   previous number
# Throws        : None
# Comments      : None
# See Also      : None
sub encode_number {
    my $number      = shift;
    my $prev_number = shift;

    $number = sprintf '%.0f', $number * $OneE5;

    my $number_diff = $number - $prev_number;
    my $number_str  = $number_diff;

    if ( $number_diff < 0 ) {
        $number_str = ( ~( $number_str * -1 ) ) + 1;
    }

    $number_str = $number_str << 1;

    if ( $number_diff < 0 ) {
        $number_str = ~$number_str;
    }

    $number_str = unpack( "B32", pack( "N", $number_str ) );

    my @chunk_list;
    while ( $number_str =~ s/(\d{5})$//xsm ) {
        push @chunk_list, $1;
    }

    while ( $chunk_list[-1] =~ /0{5}/xsm ) {
        if ($#chunk_list) {
            pop @chunk_list;
        }
        else {
            last;
        }
    }

    for ( 0 .. $#chunk_list ) {
        $chunk_list[$_] = unpack( "N",
            pack( "B32", substr( "0" x 32 . $chunk_list[$_], -32 ) ) );
        if ( $_ < $#chunk_list ) {
            $chunk_list[$_] = $chunk_list[$_] | hex '0x20';
        }
        $chunk_list[$_] = chr $chunk_list[$_] + 63;
    }

    $number_str = join q{}, @chunk_list;
    $number_str =~ s/\\/\\\\/gxsm;

    return ( $number_str, $number );
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

    # Get the command line options
    GetOptions( $opts_ref, 'help|?', 'man', 'writeman=i' )
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

    return;
}

__END__

=head1 NAME

Polyline.pm - This modulino encodes a string of coordinates supplied as
arguments

=head1 VERSION

This documentation refers to Polyline.pm version 0.01

=head1 USAGE

Brief usage examples.
./Polyline.pm -- "5,5" "10,10"

=head1 REQUIRED ARGUMENTS

At least 1 coordinate must be supplied.

=head1 SYNOPSIS

Polyline.pm [options]

  Options:
    --help|?               brief help message
    --man                  full documentation
    --writeman=i           write out a manpage

=head1 OPTIONS

=over 8

=item B<--help>

Print a brief help message and exits.

=item B<--man>

Prints the manual page and exits.

=item B<--writeman>

Specify the manpage section and then write out the manpage to the current
directory as SCRIPTNAME.*

=back

=head1 DESCRIPTION

B<Polyline.pm> is a modulino that encodes a set of coordinates supplied
as arguments.  When run from the command line make sure to use -- before any
coordinates so negative number are not interpreted as options.  To create an
encoded polyline for a polygon, the first and last coordinates must be the
same.

=head1 DIAGNOSTICS

None

=head1 EXIT STATUS

None

=head1 CONFIGURATION

None

=head1 DEPENDENCIES

perldoc perlmodlib

- Perl Distribution -
strict
warnings
Pod::Usage
Pod::Man
Getopt::Long
autodie
Carp
English
Readonly

- CPAN -
IPC::System::Simple (required by use autodie ( :all )

=head1 INCOMPATIBILITIES

None

=head1 BUGS AND LIMITATIONS

There are no known bugs in the module.
Please report problems to Alex Dioso (alex.dioso@ikaika.org)
Patches are welcome.

=head1 AUTHOR

Alex Dioso (alex.dioso@ikaika.org)

=head1 LICENSE AND COPYRIGHT

Copyright 2010,2011 Alex Dioso (alex.dioso@ikaika.org).  All rights reserved.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.

=cut
