# -*- cperl -*-
# WSG - WebSiteGenerator

use Tatsumaki::Error;
use Tatsumaki::Application;
use Tatsumaki::HTTPClient;
use Tatsumaki::Server;

package WelcomeHandler;
use parent qw(Tatsumaki::Handler);

sub get {
    my $self = shift;
    $self->render("welcome.html.mt");
}

package SentencesHandler;
use parent qw(Tatsumaki::Handler);
use JSON qw(to_json);
use Acme::Lingua::ZH::Remix;

sub get {
    my $self = shift;
    my $n = $self->request->param("n") || 1;
    my @sentences;

    push(@sentences, rand_sentence) while($n-->0);

    $self->finish( to_json({ sentences => \@sentences }) )
}

package main;

my $app = Tatsumaki::Application->new([
    '/sentences' => 'SentencesHandler',
    '/' => 'WelcomeHandler',
]);

return $app;
