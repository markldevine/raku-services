unit class Repository::Vendors:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;

use Repository::Vendors::Oracle;

has $.db is required;

my %services;

submethod TWEAK {
    %services<oracle>       = Repository::Vendors::Oracle.new(:$!db);
}

method routes () {
    route {
        include oracle      => %services<oracle>.routes;
    }
}

=finish
