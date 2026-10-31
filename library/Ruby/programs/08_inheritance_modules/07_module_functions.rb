# module_function and extend self for utility modules.
module TextUtils
  module_function

  def slugify(s) = s.downcase.strip.gsub(/[^a-z0-9]+/, "-").gsub(/\A-|-\z/, "")
  def truncate(s, n) = s.length > n ? s[0, n - 3] + "..." : s
  def word_count(s) = s.split.size
end

module Stats
  extend self

  def mean(xs) = xs.sum.fdiv(xs.size)
  def median(xs)
    s = xs.sort
    s.size.odd? ? s[s.size / 2] : (s[s.size / 2 - 1] + s[s.size / 2]) / 2.0
  end
end

puts TextUtils.slugify("  Hello, World! Ruby 3.4  ")
puts TextUtils.truncate("A very long sentence indeed", 12)
puts TextUtils.word_count("one two three")
puts Stats.mean([1, 2, 3, 4])
puts Stats.median([7, 1, 3, 9])

class Article
  include TextUtils
  def initialize(title) = @title = title
  def url = "/posts/#{slugify(@title)}"
end
puts Article.new("Modules & Mixins in Ruby").url
