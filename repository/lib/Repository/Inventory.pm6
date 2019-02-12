unit class Repository::Inventory:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;

use Repository::Inventory::SPEED;

has $.db is required;

my %services;

submethod TWEAK {
    %services<speed>    = Repository::Inventory::SPEED.new(:$!db);
}

method routes () {
    route {
        include speed   => %services<speed>.routes;
    }
}

=finish
