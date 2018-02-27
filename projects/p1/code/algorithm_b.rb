# This method fulfills Task C5. It is Algorithm B.
def constant_compare string1, string2
  # First check that we have the right inputs
  raise 'This method only compares strings' unless String === string1 && String === string2

  # Trim carriage returns and determine longer string
  string1.chomp! && string2.chomp!
  a = [string1,string2].max_by(&:length)
  b = [string1,string2].min_by(&:length)

  # Now check lengths and always go with first
  # (string1 is assumed to be the system string we're comparing the user-input against)
  len = string1.length

  # Now set boolean and check each character for mismatch
  bool = (a.length == b.length)
  for i in (0...len)
    if a[i].nil? || b[i].nil?
      bool = (a[0] == a[0]) && bool
    else
      bool = (a[i] == b[i]) && bool
    end
  end

  return bool
end
