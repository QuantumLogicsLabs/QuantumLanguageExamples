# Builds acronyms and initials.
def acronym(phrase)
  phrase.split(/[\s-]+/).map { |w| w[0] }.join.upcase
end

def initials(name)
  parts = name.split
  parts[0..-2].map { |p| "#{p[0]}." }.push(parts[-1]).join(" ")
end

phrases = ["Portable Network Graphics", "As soon as possible", "Complementary metal-oxide semiconductor",
           "Ruby on Rails", "object oriented programming"]
phrases.each { |p| puts "#{acronym(p).ljust(6)} #{p}" }

["Grace Brewster Murray Hopper", "Yukihiro Matsumoto", "Alan Mathison Turing"].each do |n|
  puts initials(n)
end
