# Printing a nested file tree with sizes.
TREE = {
  "src" => {
    "main.rb" => 1200,
    "lib" => { "parser.rb" => 3400, "lexer.rb" => 2100, "util" => { "strings.rb" => 600 } },
    "README.md" => 800
  },
  "test" => { "parser_test.rb" => 1500 },
  "Gemfile" => 120
}.freeze

def total_size(node) = node.is_a?(Hash) ? node.sum { |_, v| total_size(v) } : node

def render(node, prefix = "")
  entries = node.sort_by { |name, v| [v.is_a?(Hash) ? 0 : 1, name] }
  entries.each_with_index do |(name, v), i|
    last = i == entries.size - 1
    branch = last ? "`-- " : "|-- "
    if v.is_a?(Hash)
      puts "#{prefix}#{branch}#{name}/ (#{total_size(v)})"
      render(v, prefix + (last ? "    " : "|   "))
    else
      puts "#{prefix}#{branch}#{name} (#{v})"
    end
  end
end

def find_files(node, path = []) = node.flat_map { |n, v| v.is_a?(Hash) ? find_files(v, path + [n]) : [(path + [n]).join("/")] }

puts ". (#{total_size(TREE)})"
render(TREE)
puts find_files(TREE).select { |f| f.end_with?(".rb") }.inspect
