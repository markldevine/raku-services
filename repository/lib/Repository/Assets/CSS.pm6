unit class Repository::Assets::CSS:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;
use Repository::Assets::CSS::NFL;

my %services;

submethod TWEAK {
    %services<nfl>  = Repository::Assets::CSS::NFL.new;
}

method routes () {
    route {
        get         -> { static 'assets/css/default.css'; }
        include nfl => %services<nfl>.routes;
    }
}

=finish
