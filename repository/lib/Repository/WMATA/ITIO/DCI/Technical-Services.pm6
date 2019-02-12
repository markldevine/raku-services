unit class Repository::WMATA::ITIO::DCI::Technical-Services:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;

use Repository::WMATA::ITIO::DCI::Technical-Services::Staff;

has $.db is required;

my %services;

submethod TWEAK {
    %services<staff>    = Repository::WMATA::ITIO::DCI::Technical-Services::Staff.new(:$!db);
}

method routes () {
    route {
        include staff   => %services<staff>.routes;
    }
}

=finish
