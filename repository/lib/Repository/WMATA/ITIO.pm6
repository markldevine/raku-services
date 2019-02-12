unit class Repository::WMATA::ITIO:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;

use Repository::WMATA::ITIO::DCI;

has $.db is required;

my %services;

submethod TWEAK {
    %services<dci>  = Repository::WMATA::ITIO::DCI.new(:$!db);
}

method routes () {
    route {
        include dci => %services<dci>.routes;
    }
}

=finish
