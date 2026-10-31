# Recursively pretty-prints nested hashes and arrays.
def pretty(value, indent = 0)
  pad = "  " * indent
  case value
  when Hash
    value.each do |k, v|
      if v.is_a?(Hash) || v.is_a?(Array)
        puts "#{pad}#{k}:"
        pretty(v, indent + 1)
      else
        puts "#{pad}#{k}: #{v.inspect}"
      end
    end
  when Array
    value.each_with_index do |v, i|
      if v.is_a?(Hash) || v.is_a?(Array)
        puts "#{pad}- [#{i}]"
        pretty(v, indent + 1)
      else
        puts "#{pad}- #{v.inspect}"
      end
    end
  end
end

data = {
  name: "Quantum",
  version: [1, 4, 2],
  authors: [{ name: "Kim", role: "lead" }, { name: "Lee", role: "dev" }],
  settings: { strict: false, depth: 3, tags: %w[fast small] }
}
pretty(data)
