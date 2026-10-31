# Mastermind: guessing a code by keeping only consistent candidates.
COLORS = %w[R G B Y O P].freeze
ALL = COLORS.repeated_permutation(4).to_a.freeze

def score(guess, secret)
  black = guess.zip(secret).count { |g, s| g == s }
  common = COLORS.sum { |c| [guess.count(c), secret.count(c)].min }
  [black, common - black]
end

def play(secret)
  candidates = ALL
  guess = %w[R R G G]
  turns = []
  loop do
    fb = score(guess, secret)
    turns << "#{guess.join} -> #{fb[0]} black, #{fb[1]} white (#{candidates.size} candidates)"
    break if fb == [4, 0]
    candidates = candidates.select { |c| score(guess, c) == fb }
    guess = candidates.first
  end
  turns
end

[%w[B Y O R], %w[P P G R], %w[R G B Y]].each do |secret|
  turns = play(secret)
  puts "secret #{secret.join}: solved in #{turns.size}"
  turns.each { |t| puts "  #{t}" }
end
