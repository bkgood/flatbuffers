package Google::FlatBuffers;

use strict;
use warnings;

sub get_float {
    return unpack 'f', substr @_[0, 1];
}

package Vec3 {
    my @FIELDS = qw/ x y z /;
    my $FORMAT = '<f<f<f';

    sub new {
        @_ == 4 or die "need three values";

        return bless \(pack $FORMAT, @_[1 .. 3]), Vec3;
    }

    sub x {
        # $_[0] is the substring pointing at the beginning of the struct.
        return unpack '<f', substr $$_[0], 0;
    }

    sub y {
        return unpack '<f', substr $$_[0], 4;
    }

    sub z {
        return unpack '<f', substr $$_[0], 8;
    }

    sub as_hash {
        my %h;

        @h{@FIELDS} = unpack $FORMAT, $$_[0];

        return \%h;
    }
}

package Monster {
    sub pos {
        # figure out the offset of struct and return a substr beginning at that
        # offset, blessed with Vec3.
        return Google::FlatBuffers::get_struct('Vec3', 4);
    }
}
1
