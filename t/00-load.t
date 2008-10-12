#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Module::Install::DBICx::AutoDoc' );
}

diag( "Testing Module::Install::DBICx::AutoDoc $Module::Install::DBICx::AutoDoc::VERSION, Perl $], $^X" );
