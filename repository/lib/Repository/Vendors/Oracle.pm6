unit class Repository::Vendors::Oracle:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;

use Repository::Vendors::Oracle::Customer-Support-Identifiers;
use Repository::Vendors::Oracle::Engineered-Systems;
use Repository::Vendors::Oracle::Contacts;
use Repository::Vendors::Oracle::Advanced-Support-Gateways;

has $.db is required;

my %services;

submethod TWEAK {
    %services<customer-support-identifiers> = Repository::Vendors::Oracle::Customer-Support-Identifiers.new(:$!db);
    %services<engineered-systems>           = Repository::Vendors::Oracle::Engineered-Systems.new(:$!db);
    %services<contacts>                     = Repository::Vendors::Oracle::Contacts.new(:$!db);
    %services<advanced-support-gateways>    = Repository::Vendors::Oracle::Advanced-Support-Gateways.new(:$!db);

}

method routes () {
    route {
        include customer-support-identifiers    => %services<customer-support-identifiers>.routes,
                engineered-systems              => %services<engineered-systems>.routes,
                contacts                        => %services<contacts>.routes,
                advanced-support-gateways       => %services<advanced-support-gateways>.routes;
    }
}

=finish
