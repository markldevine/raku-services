unit class Repository::Inventory::SPEED:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;

use Repository::Inventory::SPEED::OEDA;

has $.db is required;

my %services;

submethod TWEAK {
    %services<oeda>     = Repository::Inventory::SPEED::OEDA.new(:$!db);
}

method routes () {
    route {
        include oeda    => %services<oeda>.routes;
    }
}

=finish
