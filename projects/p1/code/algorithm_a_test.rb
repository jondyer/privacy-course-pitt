###################################################################################
# Execution: 			ruby algorithm_a_test.rb
# Dependencies:		benchmark  			(included in Ruby standard library)
# 								benchmark-ips 	(must be installed, listed in Gemfile)
#
# This is the demo program for Algorithm A, the naive string comparison. The
# results include, most importantly, the "clock time" for the algorithm on various
# inputs. The benchmark module will run the given code once to initialize state,
# and then test the code. The labels are all pretty self-explanatory.
###################################################################################
require 'benchmark'
require 'benchmark/ips'
require_relative 'algorithm_a'

# Boilerplate --> we'll try a couple different lengths of string: one regular and one a 32-byte hash value
strings_to_test = [['This is a good dog','This is a good dog'], ['This is a good dog','This is a good dot'], ['This is a good dog','String same length'], ['This is a good dog',' ']]
hashes_to_test = [['286755fad04869ca523320acce0dc6a4','286755fad04869ca523320acce0dc6a4'], ['286755fad04869ca523320acce0dc6a4','286755fad04869ca523320acce0dc6a5'], ['286755fad04869ca523320acce0dc6a4', 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'], ['286755fad04869ca523320acce0dc6a4','smaller string']]


######################################################################################################
# First the regular string: 'This is a good dog'
puts 'TESTING WITH THE FOLLOWING STRING: \'This is a good dog\''

# This block simply returns the time it takes to perform 100 iterations of each type of comparison.
Benchmark.bm(30) do |x|
	x.report('Diff strings, diff length:')			{ 1000.times { naive_compare(strings_to_test[3][0],strings_to_test[3][1]) } }
	x.report('Diff strings, same length:')			{ 1000.times { naive_compare(strings_to_test[2][0],strings_to_test[2][1]) } }
	x.report('Close strings, same length:')			{ 1000.times { naive_compare(strings_to_test[1][0],strings_to_test[1][1]) } }
	x.report('Strings are identical:')					{ 1000.times { naive_compare(strings_to_test[0][0],strings_to_test[0][1]) } }
end

# This block measures how many iterations per second are possible with each type of comparison, and gives relative results.
Benchmark.ips do |x|
	x.report('Diff strings, diff length:')			{ naive_compare(strings_to_test[3][0],strings_to_test[3][1]) }
	x.report('Diff strings, same length:')			{ naive_compare(strings_to_test[2][0],strings_to_test[2][1]) }
	x.report('Close strings, same length:')			{ naive_compare(strings_to_test[1][0],strings_to_test[1][1]) }
	x.report('The strings are identical:')			{ naive_compare(strings_to_test[0][0],strings_to_test[0][1]) }

	x.compare!
end


######################################################################################################
# Now the string of the hash value: '286755fad04869ca523320acce0dc6a4'
puts 'TESTING WITH THE FOLLOWING HASH VALUE: \'286755fad04869ca523320acce0dc6a4\''

# This block simply returns the time it takes to perform 100 iterations of each type of comparison.
Benchmark.bm(30) do |x|
	x.report('Diff strings, diff length:')			{ 1000.times { naive_compare(hashes_to_test[3][0],hashes_to_test[3][1]) } }
	x.report('Diff strings, same length:')			{ 1000.times { naive_compare(hashes_to_test[2][0],hashes_to_test[2][1]) } }
	x.report('Close strings, same length:')			{ 1000.times { naive_compare(hashes_to_test[1][0],hashes_to_test[1][1]) } }
	x.report('Strings are identical:')					{ 1000.times { naive_compare(hashes_to_test[0][0],hashes_to_test[0][1]) } }
end

# This block measures how many iterations per second are possible with each type of comparison, and gives relative results.
Benchmark.ips do |x|
	x.report('Diff strings, diff length:')			{ naive_compare(hashes_to_test[3][0],hashes_to_test[3][1]) }
	x.report('Diff strings, same length:')			{ naive_compare(hashes_to_test[2][0],hashes_to_test[2][1]) }
	x.report('Close strings, same length:')			{ naive_compare(hashes_to_test[1][0],hashes_to_test[1][1]) }
	x.report('The strings are identical:')			{ naive_compare(hashes_to_test[0][0],hashes_to_test[0][1]) }

	x.compare!
end


################################################################################
# Sample output:	(run on 64-bit Ubuntu 16.04 w/ 4GB RAM)
#
# TESTING WITH THE FOLLOWING STRING: 'This is a good dog'
#                                      user     system      total        real
# Diff strings, diff length:       0.000226   0.000062   0.000288 (  0.000285)
# Diff strings, same length:       0.002930   0.000000   0.002930 (  0.002925)
# Close strings, same length:      0.008607   0.000008   0.008615 (  0.008633)
# Strings are identical:           0.006213   0.000470   0.006683 (  0.006682)
# Warming up --------------------------------------
# Diff strings, diff length:
#                        188.343k i/100ms
# Diff strings, same length:
#                         33.966k i/100ms
# Close strings, same length:
#                         16.227k i/100ms
# The strings are identical:
#                         16.294k i/100ms
# Calculating -------------------------------------
# Diff strings, diff length:
#                           3.263M (± 1.2%) i/s -     16.386M in   5.023051s
# Diff strings, same length:
#                         386.523k (± 1.1%) i/s -      1.936M in   5.009481s
# Close strings, same length:
#                         170.027k (± 1.1%) i/s -    860.031k in   5.058874s
# The strings are identical:
#                         171.550k (± 1.1%) i/s -    863.582k in   5.034567s
#
# Comparison:
# Diff strings, diff length::  3262636.2 i/s
# Diff strings, same length::   386523.1 i/s - 8.44x  slower
# The strings are identical::   171550.3 i/s - 19.02x  slower
# Close strings, same length::   170026.9 i/s - 19.19x  slower
#
# TESTING WITH THE FOLLOWING HASH VALUE: '286755fad04869ca523320acce0dc6a4'
#                                      user     system      total        real
# Diff strings, diff length:       0.000285   0.000000   0.000285 (  0.000282)
# Diff strings, same length:       0.003896   0.000000   0.003896 (  0.003896)
# Close strings, same length:      0.011190   0.000000   0.011190 (  0.011195)
# Strings are identical:           0.011963   0.000000   0.011963 (  0.011967)
# Warming up --------------------------------------
# Diff strings, diff length:
#                        184.127k i/100ms
# Diff strings, same length:
#                         25.864k i/100ms
# Close strings, same length:
#                         10.086k i/100ms
# The strings are identical:
#                         10.163k i/100ms
# Calculating -------------------------------------
# Diff strings, diff length:
#                           3.207M (± 2.2%) i/s -     16.203M in   5.054624s
# Diff strings, same length:
#                         280.709k (± 1.1%) i/s -      1.423M in   5.068163s
# Close strings, same length:
#                         104.985k (± 1.8%) i/s -    534.558k in   5.093492s
# The strings are identical:
#                         103.680k (± 6.0%) i/s -    518.313k in   5.022938s
#
# Comparison:
# Diff strings, diff length::  3207413.1 i/s
# Diff strings, same length::   280709.4 i/s - 11.43x  slower
# Close strings, same length::   104985.1 i/s - 30.55x  slower
# The strings are identical::   103679.6 i/s - 30.94x  slower
################################################################################
