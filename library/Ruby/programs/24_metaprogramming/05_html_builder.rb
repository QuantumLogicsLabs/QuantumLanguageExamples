# An HTML builder DSL using instance_eval and method_missing.
class HTML
  def initialize
    @out = +""
    @depth = 0
  end

  def self.build(&block) = new.tap { |h| h.instance_eval(&block) }.to_s

  def text(s) = @out << "  " * @depth << s.to_s << "\n"

  # `p_` stands for <p>: a bare `p` would call Kernel#p
  def method_missing(name, content = nil, **attrs, &block)
    tag = name.to_s.delete_suffix("_")
    attr_s = attrs.map { |k, v| " #{k}=\"#{v}\"" }.join
    if block
      @out << "  " * @depth << "<#{tag}#{attr_s}>\n"
      @depth += 1
      instance_eval(&block)
      @depth -= 1
      @out << "  " * @depth << "</#{tag}>\n"
    else
      @out << "  " * @depth << "<#{tag}#{attr_s}>#{content}</#{tag}>\n"
    end
    self
  end

  def respond_to_missing?(*) = true
  def to_s = @out
end

items = %w[Ruby Elixir Crystal]
puts(HTML.build do
  html(lang: "en") do
    head { title "Languages" }
    body(class: "main") do
      h1 "Favourite languages"
      ul { items.each { |i| li i, class: "lang" } }
      p_ "Total: #{items.size}"
    end
  end
end)
