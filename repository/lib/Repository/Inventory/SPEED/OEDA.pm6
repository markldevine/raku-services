unit class Repository::Inventory::SPEED::OEDA:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;

use Repository::Inventory::SPEED::OEDA::CTX2;
use Repository::Inventory::SPEED::OEDA::CTX3;
use Repository::Inventory::SPEED::OEDA::CTX4;
use Repository::Inventory::SPEED::OEDA::CTZ1;
use Repository::Inventory::SPEED::OEDA::JGX2;
use Repository::Inventory::SPEED::OEDA::JGX3;
use Repository::Inventory::SPEED::OEDA::JGX4;
use Repository::Inventory::SPEED::OEDA::JGZ1;

has $.db is required;

my %services;

submethod TWEAK {
    %services<ctx2>     = Repository::Inventory::SPEED::OEDA::CTX2.new(:$!db);
    %services<ctx3>     = Repository::Inventory::SPEED::OEDA::CTX3.new(:$!db);
    %services<ctx4>     = Repository::Inventory::SPEED::OEDA::CTX4.new(:$!db);
    %services<ctz1>     = Repository::Inventory::SPEED::OEDA::CTZ1.new(:$!db);
    %services<jgx2>     = Repository::Inventory::SPEED::OEDA::JGX2.new(:$!db);
    %services<jgx3>     = Repository::Inventory::SPEED::OEDA::JGX3.new(:$!db);
    %services<jgx4>     = Repository::Inventory::SPEED::OEDA::JGX4.new(:$!db);
    %services<jgz1>     = Repository::Inventory::SPEED::OEDA::JGZ1.new(:$!db);
}

method routes () {
    route {
        include ctx2    => %services<ctx2>.routes;
        include ctx3    => %services<ctx3>.routes;
        include ctx4    => %services<ctx4>.routes;
        include ctz1    => %services<ctz1>.routes;
        include jgx2    => %services<jgx2>.routes;
        include jgx3    => %services<jgx3>.routes;
        include jgx4    => %services<jgx4>.routes;
        include jgz1    => %services<jgz1>.routes;
    }
}

=finish
