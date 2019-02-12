unit class E028441::Assets::CSS:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;

method routes () {
    route {
        get ->          { static 'assets/css/default.css' }
    }
}

=finish
