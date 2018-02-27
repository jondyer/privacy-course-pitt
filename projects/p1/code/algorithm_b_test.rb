###################################################################################
# Execution: 			ruby algorithm_b_test.rb
# Dependencies:		benchmark  			(included in Ruby standard library)
# 								benchmark-ips 	(must be installed, listed in Gemfile)
#
# This is the demo program for Algorithm B, the constant string comparison. The
# results include, most importantly, the "clock time" for the algorithm on various
# inputs. The benchmark module will run the given code once to initialize state,
# and then test the code. The labels are all pretty self-explanatory.
###################################################################################
require 'benchmark'
require 'benchmark/ips'
require_relative 'algorithm_b'

# Boilerplate --> we'll try a couple different lengths of string: one regular and one a 32-byte hash value
strings_to_test = [['This is a good dog','This is a good dog'], ['This is a good dog','This is a good dot'], ['This is a good dog','String same length'], ['This is a good dog',' ']]
hashes_to_test = [['286755fad04869ca523320acce0dc6a4','286755fad04869ca523320acce0dc6a4'], ['286755fad04869ca523320acce0dc6a4','286755fad04869ca523320acce0dc6a5'], ['286755fad04869ca523320acce0dc6a4', 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'], ['286755fad04869ca523320acce0dc6a4','smaller string']]


######################################################################################################
# First the regular string: 'This is a good dog'
puts 'TESTING WITH THE FOLLOWING STRING: \'This is a good dog\''

# This block simply returns the time it takes to perform 100 iterations of each type of comparison.
Benchmark.bm(30) do |x|
	x.report('Diff strings, diff length:')			{ 1000.times { constant_compare(strings_to_test[3][0],strings_to_test[3][1]) } }
	x.report('Diff strings, same length:')			{ 1000.times { constant_compare(strings_to_test[2][0],strings_to_test[2][1]) } }
	x.report('Close strings, same length:')			{ 1000.times { constant_compare(strings_to_test[1][0],strings_to_test[1][1]) } }
	x.report('Strings are identical:')					{ 1000.times { constant_compare(strings_to_test[0][0],strings_to_test[0][1]) } }
end

# This block measures how many iterations per second are possible with each type of comparison, and gives relative results.
Benchmark.ips do |x|
	x.report('Diff strings, diff length:')			{ constant_compare(strings_to_test[3][0],strings_to_test[3][1]) }
	x.report('Diff strings, same length:')			{ constant_compare(strings_to_test[2][0],strings_to_test[2][1]) }
	x.report('Close strings, same length:')			{ constant_compare(strings_to_test[1][0],strings_to_test[1][1]) }
	x.report('The strings are identical:')			{ constant_compare(strings_to_test[0][0],strings_to_test[0][1]) }

	x.compare!
end


######################################################################################################
# Now the string of the hash value: '286755fad04869ca523320acce0dc6a4'
puts 'TESTING WITH THE FOLLOWING HASH VALUE: \'286755fad04869ca523320acce0dc6a4\''

# This block simply returns the time it takes to perform 100 iterations of each type of comparison.
Benchmark.bm(30) do |x|
	x.report('Diff strings, diff length:')			{ 1000.times { constant_compare(hashes_to_test[3][0],hashes_to_test[3][1]) } }
	x.report('Diff strings, same length:')			{ 1000.times { constant_compare(hashes_to_test[2][0],hashes_to_test[2][1]) } }
	x.report('Close strings, same length:')			{ 1000.times { constant_compare(hashes_to_test[1][0],hashes_to_test[1][1]) } }
	x.report('Strings are identical:')					{ 1000.times { constant_compare(hashes_to_test[0][0],hashes_to_test[0][1]) } }
end

# This block measures how many iterations per second are possible with each type of comparison, and gives relative results.
Benchmark.ips do |x|
	x.report('Diff strings, diff length:')			{ constant_compare(hashes_to_test[3][0],hashes_to_test[3][1]) }
	x.report('Diff strings, same length:')			{ constant_compare(hashes_to_test[2][0],hashes_to_test[2][1]) }
	x.report('Close strings, same length:')			{ constant_compare(hashes_to_test[1][0],hashes_to_test[1][1]) }
	x.report('The strings are identical:')			{ constant_compare(hashes_to_test[0][0],hashes_to_test[0][1]) }

	x.compare!
end


################################################################################
# Sample output:	(run on 64-bit Ubuntu 16.04 w/ 4GB RAM)
#
# TESTING WITH THE FOLLOWING STRING: 'This is a good dog'
#                                      user     system      total        real
# Diff strings, diff length:       0.010597   0.000000   0.010597 (  0.010596)
# Diff strings, same length:       0.011366   0.000000   0.011366 (  0.011366)
# Close strings, same length:      0.012660   0.000000   0.012660 (  0.012686)
# Strings are identical:           0.011179   0.000000   0.011179 (  0.011168)
# Warming up --------------------------------------
# Diff strings, diff length:
#                          9.522k i/100ms
# Diff strings, same length:
#                          8.632k i/100ms
# Close strings, same length:
#                          8.628k i/100ms
# The strings are identical:
#                          8.616k i/100ms
# Calculating -------------------------------------
# Diff strings, diff length:
#                          97.921k (± 1.6%) i/s -    495.144k in   5.057841s
# Diff strings, same length:
#                          85.590k (± 6.6%) i/s -    431.600k in   5.070787s
# Close strings, same length:
#                          86.376k (± 5.5%) i/s -    431.400k in   5.013725s
# The strings are identical:
#                          87.895k (± 2.7%) i/s -    439.416k in   5.003235s
#
# Comparison:
# Diff strings, diff length::    97921.0 i/s
# The strings are identical::    87895.1 i/s - 1.11x  slower
# Close strings, same length::    86376.3 i/s - 1.13x  slower
# Diff strings, same length::    85590.0 i/s - 1.14x  slower
#
# TESTING WITH THE FOLLOWING HASH VALUE: '286755fad04869ca523320acce0dc6a4'
#                                      user     system      total        real
# Diff strings, diff length:       0.018838   0.000000   0.018838 (  0.018902)
# Diff strings, same length:       0.020607   0.000000   0.020607 (  0.020629)
# Close strings, same length:      0.019991   0.000000   0.019991 (  0.019993)
# Strings are identical:           0.019804   0.000000   0.019804 (  0.019806)
# Warming up --------------------------------------
# Diff strings, diff length:
#                          5.409k i/100ms
# Diff strings, same length:
#                          5.110k i/100ms
# Close strings, same length:
#                          5.105k i/100ms
# The strings are identical:
#                          4.708k i/100ms
# Calculating -------------------------------------
# Diff strings, diff length:
#                          52.482k (±10.3%) i/s -    259.632k in   5.018875s
# Diff strings, same length:
#                          51.108k (± 8.2%) i/s -    255.500k in   5.053021s
# Close strings, same length:
#                          51.922k (± 2.0%) i/s -    260.355k in   5.016389s
# The strings are identical:
#                          52.152k (± 1.9%) i/s -    263.648k in   5.057355s
#
# Comparison:
# Diff strings, diff length::    52482.3 i/s
# The strings are identical::    52151.6 i/s - same-ish: difference falls within error
# Close strings, same length::    51922.0 i/s - same-ish: difference falls within error
# Diff strings, same length::    51107.8 i/s - same-ish: difference falls within error
################################################################################
