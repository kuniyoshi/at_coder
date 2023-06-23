use strict;
use warnings;
use Test::More tests => 7;
use AVLTree;

my $tree = AVLTree->new(5, "five");

$tree->insert(3, "three");
$tree->insert(2, "two");
$tree->insert(4, "four");
$tree->insert(7, "seven");
$tree->insert(6, "six");
$tree->insert(8, "eight");

is($tree->search(4), "four", "Search existing key");
is($tree->search(1), undef, "Search non-existing key");

$tree->delete(4);
is($tree->search(4), undef, "Delete existing key");

$tree->delete(1);
is($tree->search(2), "two", "Delete non-existing key doesn't affect the tree");

$tree->insert(4, "four_new");
is($tree->search(4), "four_new", "Re-insert key with new value");

$tree->delete(5);
is($tree->search(5), undef, "Delete root key");
is($tree->search(6), "six", "Check another key after root key deletion");
