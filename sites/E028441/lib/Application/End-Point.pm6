unit class Application::End-Point:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

has %.links;
#   {
#     "Link 1": "http://ctunixvmadminpv.wmata.local:20000/wmata/itio/dci/technical-services/staff",
#     "Link 2": "http://ctunixvmadminpv.wmata.local:20000/wmata/itio/dci/technical-services/staff",
#   }

        $!html  ~= '<!DOCTYPE html><html>';
        $!html  ~= '<head>';
        $!html  ~= '<title>' ~ $!caption ~ '</title>';
        if $!div-css {
            $!html  ~= '<link rel="stylesheet" href="' ~ $!div-css ~ '">';
        }
        else {
            $!html  ~= '<link rel="stylesheet" href="/assets/default.css">';
        }
        $!html  ~= '</head>';
        $!html  ~= '<body>';
    }

=finish
