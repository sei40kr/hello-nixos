## Basic values

# A string
"Hello world";
# A string containing an expression
"${pkgs.bash}/bin/sh";
# Booleans
true;
false;
# An integer
123;
# A path (relative to the containing Nix expression)
./foo.png;

## Compound values

# A set with attributes named x and y
{ x = 1; y = 2; };
# A nested set, equvalent to { foo = { bar = 1; }; }
{ foo.bar = 1 };
# A recursive set, equivalent to { x = "foo"; y = "foobar"; }
rec { x = "foo"; y = x + "bar"; };
# A list with two elements
[ "foo" "bar" ];

## Operators

# String concatenation
"foo" + "bar";
# Integer addition
1 + 2;
# Equality test (evaluates to true)
"foo" == "f" + "oo";
# Inequality test (evaluates to true)
"foo" != "bar";
# Boolean negation
!true;
# Attributes selection (evaluates to 1)
{ x = 1; y = 2; }.x;
# Attributes selection with default (evaluates to 3)
{ x = 1; y = 2; }.z or 3;
# Merge two sets (attributes in the right-hand set taking precedense)
{ x = 1; y = 2; } // { z = 3; };

## Control structures

# Conditional expression
if 1 + 1 == 2 then "yes!" else "no";
# Assertion check
assert 1 + 1 == 2; "yes!";
# Variable definition
let x = "foo"; y = "bar";
in x + y;
# Add all attributes from the given set to the scope (evaluates to 1)
with pkgs.lib; head [ 1 2 3 ];

## Functions (lambdas)

# A function that expects an integer and returns it increased by 1
x: x + 1;
# A function call (evaluates to 101)
(x: x + 1) 100;
# A function bound to a variable and subsequently called by name (evaluates to
# 103)
let inc = x: x + 1; in inc (inc (inc 100));
# A function that expects a set with required attributes x and y and
# concatenates them
{ x, y }: x + y;
# A function that expects a set with required attribute x and optional y, using
# "bar" as default value for y
  { x, y ? "bar" }: x + y;
# A function that expects a set with required attributes x and y and ignores any
# other attributes
{ x, y, ... }: x + y;
# A function that expects a set with required attributes x and y, and binds the
# whole set to args
{ x, y } @ args: x + y;

## Built-in functions

# Load and return Nix expression in given file
import ./foo.nix;
# Apply a function to every element of a list (evaluates to [ 2 4 6 ])
map (x: x + x) [ 1 2 3 ]
