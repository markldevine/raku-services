unit    class Repository:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use     Cro::HTTP::Router;

use     Repository::Back-End::DB::File-System;

use     Repository::Assets;
use     Repository::WMATA;
use     Repository::Vendors;
use     Repository::Inventory;
#use    Repository::Products;

has     $.db;
has     $.assets;
has     %.services;

submethod TWEAK {
    die 'Set REPOSITORY_META in your environment before proceeding.' unless %*ENV<REPOSITORY_META>:exists;
    given %*ENV<REPOSITORY_META> {
        when /^'file-system:'(\/.+)$/   { $!db = Repository::Back-End::DB::File-System.new(:root(~$0));         }
#       when /^sqllite-db:(.+)/         { $!db = Repository::Back-End::DB::SQLite.new(:connector(~$0));         }
#       when /^oracle-db:(.+)/          { $!db = Repository::Back-End::DB::Oracle::RDBMS.new(:connector(~$0));  }
#       when /^oracle-cloud:(.+)/       { $!db = Repository::Back-End::DB::Oracle::Cloud.new(:connector(~$0));  }
#       when /^aws:(/.+)/               { $!db = Repository::Back-End::DB::Amazon::S3.new(:connector(~$0));     }
        default                         { die; }
    }
    $!assets                = Repository::Assets.new;
    %!services<wmata>       = Repository::WMATA.new(:$!db);
    %!services<inventory>   = Repository::Inventory.new(:$!db);
#   %!services<products>    = Repository::Products.new(:$!db);
    %!services<vendors>     = Repository::Vendors.new(:$!db);
}

method routes () {
    route {
        get -> 'favicon.ico'    { static 'assets/favicon.ico'; }
        include assets          => $!assets.routes;
        include wmata           => %!services<wmata>.routes,
                vendors         => %!services<vendors>.routes;
#               inventory       => %!services<inventory>.routes;
#               - vcenters
#                 - clusters
#                 - datacenters
#                 - datastores
#                 - folders
#                 - hosts
#                 - networks
#                 - resource-pools
#                 - vms
#               - hmcs
#                 - frames
#                   - partitions
#                     - profiles
#               products        => %!services<inventory>.routes;
#               - aix
#               - 
#               - 
#               - isp
#               - ol
#               - rhel
#               - 
#               - 
#               - zena
#       vendors         => %!services<vendors>.routes;
#               - asg
#               - dell
#               - dlt
#               - grm
#               - ibm
#               - mythics
#               - one-identity
#               - oracle
#               - redhat
#               - sirius
#               - vmware
#               - quantum

#       get -> 'services' { content 'application/json', URIs() }
    }
}

#sub URIs () {
#    my @URIs;
#
##   for %!services.keys -> $service {
##       @URIs.push: %!services{$service}.URIs;
##   }
#
#@URIs[0] = '{"wmata": [ "dci" ]}';
#    return @URIs;
#}

=finish
