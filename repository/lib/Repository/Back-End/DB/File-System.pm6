unit class Repository::Back-End::DB::File-System:ver<0.0.1>:auth<Mark Devine (mark@markdevine.com)>;

use Cro::HTTP::Router;
use Data::Dump::Tree;
use JSON::Fast;
use URI;

use Format::HTML::Table;

use Repository::Back-End::DB::Meta;
use Repository::Back-End::DB::Meta::Input;
use Repository::Back-End::DB::Meta::Output;

has $.root is required;

my %dispatch = (
    json            => {
        html-table-data => &fetch-json-html-table-data,
    },
#   pdf             => &fetch-pdf,
#   jpeg            => &fetch-jpeg,
#   x-icon          => &fetch-icon,
#   css             => &fetch-css,
#   html            => &fetch-html,
#   link            => &fetch-link,
#   plain           => &fetch-plain,
);

method fetch (Str:D $invocant-name-space, Bool :$compose-complete-page) {
    my @name-segments = $invocant-name-space.lc.split('::').Array;
    my $id = @name-segments.join('__');
    my $file-name = @name-segments.pop;
    my $relative-dir = @name-segments.join: '/';
#   Meta file (absolute path)
    my $meta-absolute-path = self.root ~ '/' ~ $relative-dir ~ '/' ~ $file-name ~ '.meta';
    die 'No meta file: ' ~ $meta-absolute-path unless $meta-absolute-path.IO.e;
    my $meta-file-contents = from-json(slurp($meta-absolute-path));
#   Unmarshal from JSON into objects
    die 'Missing "back-end"!' unless $meta-file-contents<back-end>:exists;
    my Repository::Back-End::DB::Meta::Input $input .= new(
        :root(self.root),
        :source($meta-file-contents<back-end><source>),
    );
    die 'Missing "front-end"!' unless $meta-file-contents<front-end>:exists;
    my Repository::Back-End::DB::Meta::Output $output .= new(
        :div-default-css(
            $meta-file-contents<front-end><div-default-css> ??
            $meta-file-contents<front-end><div-default-css> !!
            Nil
        ),
        :div-id(
            $meta-file-contents<front-end><div-id> ??
            $meta-file-contents<front-end><div-id> !!
            $id
        ),
    );
    my Repository::Back-End::DB::Meta $meta-data .= new(:$input, :$output);
    my URI $uri .= new($meta-data.input.source);
    return &%dispatch{$uri.query-form<format>}{$uri.query-form<provides>}(:$meta-data, :$compose-complete-page);
}

sub fetch-json-html-table-data (Repository::Back-End::DB::Meta :$meta-data is required, Bool :$compose-complete-page) {
    my $input-file = $meta-data.input.root ~ $meta-data.input.uri.path;
    die 'No such file: ' ~ $input-file unless $input-file.IO.e;
    my %json = from-json(slurp($input-file));

    content 'text/html', Format::HTML::Table.new(
        :div-css($meta-data.output.div-default-css),
        :div-id($meta-data.output.div-id),
        :caption(%json<caption>),
        :tbody(%json<tbody>),
        :tfoot(%json<tfoot>),
        :thead(%json<thead>),
        :$compose-complete-page,
    ).html;
}

=finish
