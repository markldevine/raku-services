unit class E028441::Assets:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;
use E028441::Assets::CSS;

my %services;

submethod TWEAK {
    %services<css>  = E028441::Assets::CSS.new;
}

method routes () {
    route {
        include css => %services<css>.routes;
    }
}

=finish
