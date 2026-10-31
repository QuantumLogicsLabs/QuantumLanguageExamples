# Refinements: scoped monkey patches.
module StringExtras
  refine String do
    def shout = upcase + "!"
    def vowel_count = count("aeiouAEIOU")
  end

  refine Integer do
    def minutes = self * 60
  end
end

module Before
  def self.try = "hello".respond_to?(:shout)
end

using StringExtras

puts "hello".shout
puts "Refinements are neat".vowel_count
puts 5.minutes
puts Before.try
puts %w[a b].map { |s| s.shout }.inspect
