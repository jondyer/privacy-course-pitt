# This method fulfills Task C2. It is Algorithm A.
def naive_compare string1, string2
  # First check that we have the right inputs
  raise 'This method only compares strings' unless String === string1 && String === string2

  # Trim carriage returns and determine longer string
  string1.chomp! && string2.chomp!

  # Now check that the lengths are the same
  return false unless string1.length == string2.length

  # Now check each character for mismatch
  string1.chars.each_with_index { |char, n| return false unless char == string2[n] }

  return true
end
