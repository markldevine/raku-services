unit class Repository::WMATA::ITIO::DCI:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;

use Repository::WMATA::ITIO::DCI::Technical-Services;

has $.db is required;

my %services;

submethod TWEAK {
    %services<technical-services>   = Repository::WMATA::ITIO::DCI::Technical-Services.new(:$!db);
}

method routes () {
    route {
        include technical-services  => %services<technical-services>.routes;
    }
}

=finish
