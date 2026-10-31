# *args, **options and explicit &block parameters.
def summarize(*numbers)
  return "none" if numbers.empty?
  "#{numbers.size} numbers, total #{numbers.sum}"
end

puts summarize
puts summarize(4)
puts summarize(1, 2, 3)
values = [10, 20, 30]
puts summarize(*values)

def tag(name, content = nil, **attrs, &block)
  inner = block ? block.call : content
  attributes = attrs.map { |k, v| " #{k}=\"#{v}\"" }.join
  "<#{name}#{attributes}>#{inner}</#{name}>"
end

puts tag("p", "hello")
puts tag("a", "home", href: "/", class: "nav")
puts tag("div", id: "main") { tag("span", "inside") }
opts = { lang: "en", dir: "ltr" }
puts tag("html", "...", **opts)

def first_and_rest(first, *rest, last)
  "first=#{first} rest=#{rest.inspect} last=#{last}"
end
puts first_and_rest(1, 2)
puts first_and_rest(1, 2, 3, 4, 5)
