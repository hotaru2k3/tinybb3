#!/usr/bin/env perl

use strict;
use Encode qw(decode);
use open ':utf8';
use Fcntl qw(:flock);
use CGI;
use CGI::Carp qw(fatalsToBrowser);

BEGIN { require 'post-common.pl'; }

my $query = new CGI;
our $script_name = $query->script_name();
if($query->request_method() == 'POST')
{ my $thread = $query->param('thread');
  my $title = $query->param('title');
  my $sage = $query->param('sage');
  my $comment = $query->param('comment');
  my $pass = $query->param('pass');
  $thread = make_thread($title, $comment) unless $thread;
  add_post($thread, $sage, $comment, $pass); }
print $query->redirect(-uri => full_path(HTML_INDEX), -status => 303);
