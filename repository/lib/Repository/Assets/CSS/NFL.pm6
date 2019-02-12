unit class Repository::Assets::CSS::NFL:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

#   get -> 'cardinals.css'  { static 'assets/css/nfl/cardinals.css'; }

use Cro::HTTP::Router;

has @!teams = <
    bills
    cardinals
    dolphins
    eagles
    packers
    panthers
    ravens
    redskins
>;

has %!colors;

submethod TWEAK {
    for @!teams -> $team {
        %!colors{$team} = 'assets/css/nfl/' ~ $team ~ '.css';
    }
}

method colors ($team = @!teams.pick(1)) {
    static %!colors{$team};
}

method routes () {
    route {
        get ->          { self.colors();      }
        get -> $team    { self.colors($team); }
    }
}

=finish
