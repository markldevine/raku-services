unit class Repository::Back-End::DB::Meta::Input:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use URI;

has Str:D   $.root      is required;
has Str:D   $.source    is required;
has URI     $.uri;

submethod TWEAK {
    $!uri = URI.new($!source);
}

=finish
