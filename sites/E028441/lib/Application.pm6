unit class Application:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;
use Cro::HTTP::Client;
use Data::Dump::Tree;

constant page-title = "Mark Devine's DCI Page";
constant $css-path = 'css/default.css';

submethod TWEAK {
    die "Set environment variable 'REPOSITORY_HOST' before running." unless %*ENV<REPOSITORY_HOST>;
    die "Set environment variable 'REPOSITORY_PORT' before running." unless %*ENV<REPOSITORY_PORT>;
#%% Get all available links from DCISERVICESREGISTRY...
}

my $http-client = Cro::HTTP::Client.new(
    content-type => 'application/json',
    headers => [ User-agent => 'Cro' ]
);

method routes () {
    route {
        get -> 'default.css' { static 'assets/css/default.css' }
        get ->               { self.menu }
    }
}

method menu () {
    my $style   = q:to/ENDOFSTYLE/;
        ul {
          list-style-type: none;
          margin: 0;
          padding: 0;
          overflow: hidden;
          background-color: #333;
        }

        li {
          float: left;
        }

        li a, .dropbtn {
          display: inline-block;
          color: white;
          text-align: center;
          padding: 14px 16px;
          text-decoration: none;
        }

        li a:hover, .dropdown:hover .dropbtn {
          background-color: red;
        }

        li.dropdown {
          display: inline-block;
        }

        .dropdown-content {
          display: none;
          position: absolute;
          background-color: #f9f9f9;
          min-width: 160px;
          box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
          z-index: 1;
        }

        .dropdown-content a {
          color: black;
          padding: 12px 16px;
          text-decoration: none;
          display: block;
          text-align: left;
        }

        .dropdown-content a:hover {background-color: #f1f1f1}

        .dropdown:hover .dropdown-content {
          display: block;
        }
        ENDOFSTYLE
    my $html    = '<!DOCTYPE html>';
    $html      ~= '<head>';
    $html      ~= '  <title>' ~ page-title ~ '</title>';
    $html      ~= '  <link rel="shortcut icon" href="http://CTUNIXVMADMINPv.wmata.local:20000/favicon.ico">';
    $html      ~= '  <style>' ~ $style ~ '</style>';
    $html      ~= '</head>';
    $html      ~= '<body>';
#   $html      ~= '  <a href="http://CTUNIXVMADMINPv.wmata.local:20000/wmata/itio/dci/technical-services/staff">DCI Staff</a>';
    $html      ~= '  <ul>';
    $html      ~= '    <li><a href="#home">Home</a></li>';
    $html      ~= '    <li><a href="http://metroweb/default.aspx" target="_blank">MetroWeb</a></li>';
    $html      ~= '    <li class="dropdown">';
    $html      ~= '      <a href="javascript:void(0)" class="dropbtn">Oracle</a>';
    $html      ~= '      <div class="dropdown-content">';
    $html      ~= '        <a href="http://ctunixvmadminpv.wmata.local:20000/vendors/oracle/advanced-support-gateways/div">OAS Gateways</a>';
    $html      ~= '        <a href="http://ctunixvmadminpv.wmata.local:20000/vendors/oracle/contacts">Contacts/div</a>';
    $html      ~= '        <a href="http://ctunixvmadminpv.wmata.local:20000/vendors/oracle/customer-support-identifiers/div">CSIs</a>';
    $html      ~= '        <a href="http://ctunixvmadminpv.wmata.local:20000/vendors/oracle/engineered-systems/div">Engineered Systems</a>';
    $html      ~= '      </div>';
    $html      ~= '    </li>';
    $html      ~= '  </ul>';
    $html      ~= '  <h3>Dropdown Menu inside a Navigation Bar</h3>';
    $html      ~= '  <p>Hover over the "Dropdown" link to see the dropdown menu.</p>';
    $html      ~= '</body>';
    $html      ~= '</html>';
    content 'text/html', $html;
}

=finish
