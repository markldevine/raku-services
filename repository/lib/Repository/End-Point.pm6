unit role Repository::End-Point:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;

has $.db is required;

method routes () {
    route {
        get ->                          { $!db.fetch($?CLASS.^name, :compose-complete-page); }
        get -> 'div'                    { $!db.fetch($?CLASS.^name);                         }
    }
}

=finish
