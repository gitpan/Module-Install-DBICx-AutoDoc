package Module::Install::DBICx::AutoDoc;

BEGIN {
	use strict;
	use warnings;
	use DBICx::AutoDoc; # if this fails this module fails
	use base 'Module::Install::Base';

	our $VERSION = '0.01_01';
	use vars qw/$SCHEMA $AUTODOC_OUTPUT/;
}

sub dbicx_autodoc {
	my ($self,$schema, $path) = @_;
	
	return unless $Module::Install::AUTHOR;
	
	die "Usage: dbicx_autodoc(schema,path)\n"
		unless $schema or $path;

	$SCHEMA = $schema;
	$AUTODOC_OUTPUT = $path;
	
	$self->postamble(<<END_MAKEFILE);
autodoc :: all
\t\$(PERLRUN) -I\$(INST_LIB) -MDBICx::AutoDoc -e 'DBICx::AutoDoc->new(schema=>q/$schema/,output=>q/$path/)->fill_all_templates;'

distclean :: autodoc_clean

autodoc_clean:
\t\$(RM_RF) $path

END_MAKEFILE

}

1; # End of Module::Install::DBICx::AutoDoc
__END__

=head1 NAME

Module::Install::DBICx::AutoDoc - Use your make file to run DBICx::AutoDoc

=head1 VERSION

Version 0.01_01 - functional preview release

=head1 SYNOPSIS

	In MakeFile.PL:
		dbicx_autodoc('My::Schema','doc');

	From CLI:
		make autodoc

=head1 METHODS

=head2 dbicx_autodoc

	Adds a DBICx::AutoDoc call to Makefile

	Required arguments are:
		Schema Package
			- Defines package name for our DBIx::Class::Schema
		Directory
			- Directory to install documentation in
	
	Example:
		dbix_autodoc('My::Schema','doc');
	
	This would run DBICx::AutoDoc for My::Schema and store documents in <module-directory>/doc.

=head1 AUTHOR

Jason M. Mills, C<< <jmmills at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-module-install-dbicx-autodoc at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Module-Install-DBICx-AutoDoc>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Module::Install::DBICx::AutoDoc


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Module-Install-DBICx-AutoDoc>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Module-Install-DBICx-AutoDoc>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Module-Install-DBICx-AutoDoc>

=item * Search CPAN

L<http://search.cpan.org/dist/Module-Install-DBICx-AutoDoc>

=back

=head1 SEE ALSO
	
	Module::Install, Module::Install::AutoManifest

=head1 COPYRIGHT & LICENSE

Copyright 2008 Jason M. Mills, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

