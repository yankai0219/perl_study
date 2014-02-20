#!/usr/bin/perl
# chapter8
# Description: 


# <1> basic knowledge
# 1. declare scalar, array, hash
my $test_scal = "test_scal";
my @test_arr  = qw(arr1 arr2 arr3);
my %test_hash = ('key1' => 'value1',
              'key2' => 'value2');

# 2. use \ to create reference 
my $ref_scal = \$test_scal;
my $ref_arr  = \@test_arr;
my $ref_hash = \%test_hash;
my $ref_func = sub {print "sub ref_func\n"};

# 3. use x$ref to use reference, 
#    which x means $(means scalar), @(means array),
#          %(means hash), &(means function)
print $$ref_scal."\n";
foreach(@$ref_arr) {
  print $_ . "\n";
}

my @key = keys %$ref_hash;
foreach (@key) {
  print $_ . ":" . $$ref_hash{$_} . "\n";
}

&$ref_func;

# <2> more knowledge
# 1. how to create reference

# 1) use \
# 2) use [] create array reference
#    use {} create hash  reference
my $arr_ref = [1, 2, 4, [12, 23]];
print $$arr_ref[0].":should be 1\n";
print $$arr_ref[3][0].":should be 12\n";

$$arr_ref[0] = "change 1 to string";
print $$arr_ref[0].":should be 'change 1 to string'\n";

my $hash_ref = {
             "a" => "a_1",
             "b_arr" => $arr_ref
            };
print $$hash_ref{'a'}.":should be a_1\n";

# 3). about 8.2.2 object constructor
# 4). about 8.2.4 handle reference
# 5). aoubt 8.2.5 symble table reference

# 2. how to use reference
#   1) use x$ref
#   2) use x${ref}
#   3) use $ref->xxx, which xxx means the type of reference.
print $$ref_scal."\n" . ":should be test_scal\n";
print $ref_arr->[1] . ":should be arr2\n";
print $ref_hash->{'key1'} . ":should be value1\n";

#   Activate automatically ref_arr[3] as one hash, and
#   activate ref_arr[3]->{"English"} as one array
$ref_arr[3]->{"English"}->[0] = "hello";

print $ref_arr[3]->{"English"}->[0] . ":should be hello\n";

#    4) fake hash 8.3.5. 
#       Problem: when i try $john->{weight}, it failed.
my $john = [{age => 1, eyes => 2, weight => 3}, 47, "brown", 186];
print $john->[0]->{'weight'} . ":should be 3\n";
print $john->[2] . ":should be brown\n";
$john->[0]->{height} = 34;
print $john->[0]->{'height'} . ":should be 34\n";

print exists $john->[0]->{height};
delete $john->[0]->{height};
print exists $john->[0]->{height};
print $john->[0]->{'height'} . ":should be empty\n";


# 3. Tips

#    1) we can use \ to generate one reference. In addition,
#       we can use \ to generate one list reference 
#       if \ and one list are both used.
#       The following two relist is the same.
my @reflist1 = (\$test_scal, \@test_arr, \%test_hash);
my @reflist2 = \($test_scal, @test_arr, %test_hash);


