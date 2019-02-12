unit class Repository::WMATA:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;
use Repository::WMATA::ITIO;

has $.db is required;

my %services;

submethod TWEAK {
    %services<itio>         = Repository::WMATA::ITIO.new(:$!db);
}

method routes () {
    route {
        include itio        => %services<itio>.routes;
    }
}

=finish
