unit class Repository::Assets:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;
use Repository::Assets::CSS;

my %services;

submethod TWEAK {
    %services<css>  = Repository::Assets::CSS.new;
}

method routes () {
    route {
        include css => %services<css>.routes;
    }
}

=finish
