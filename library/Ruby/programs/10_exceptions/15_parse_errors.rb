# A tiny arithmetic parser that reports error positions.
class ParseError < StandardError
  attr_reader :position
  def initialize(message, position)
    @position = position
    super("#{message} at position #{position}")
  end
end

class Parser
  def initialize(text)
    @tokens = text.scan(/\d+|[-+*\/()]|\S/)
    @pos = 0
  end

  def parse
    value = expr
    raise ParseError.new("unexpected #{@tokens[@pos].inspect}", @pos) if @pos < @tokens.size
    value
  end

  private

  def peek = @tokens[@pos]
  def advance = (@pos += 1; @tokens[@pos - 1])

  def expr
    v = term
    v = advance == "+" ? v + term : v - term while %w[+ -].include?(peek)
    v
  end

  def term
    v = factor
    while %w[* /].include?(peek)
      op = advance
      rhs = factor
      raise ParseError.new("division by zero", @pos - 1) if op == "/" && rhs.zero?
      v = op == "*" ? v * rhs : v / rhs
    end
    v
  end

  def factor
    tok = advance
    case tok
    when /\A\d+\z/ then tok.to_i
    when "-" then -factor
    when "("
      v = expr
      raise ParseError.new("expected )", @pos) unless advance == ")"
      v
    else raise ParseError.new("unexpected #{tok.inspect}", @pos - 1)
    end
  end
end

["2 + 3 * 4", "(2 + 3) * 4", "-(8 - 10) * 3", "7 / (3 - 3)", "2 + * 3", "(1 + 2", "4 4", "100 / 7"].each do |src|
  puts "#{src.ljust(14)} = #{Parser.new(src).parse}"
rescue ParseError => e
  puts "#{src.ljust(14)} ! #{e.message}"
end
