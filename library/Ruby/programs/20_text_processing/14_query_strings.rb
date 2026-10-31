# Parsing and building query strings by hand.
def decode(s) = s.tr("+", " ").gsub(/%([0-9A-Fa-f]{2})/) { $1.hex.chr }
def encode(s) = s.gsub(/[^A-Za-z0-9_.~-]/) { |c| c == " " ? "+" : format("%%%02X", c.ord) }

def parse_query(q)
  q.split("&").each_with_object({}) do |pair, h|
    k, v = pair.split("=", 2).map { |x| decode(x.to_s) }
    if k.end_with?("[]")
      (h[k.chomp("[]")] ||= []) << v
    else
      h[k] = v
    end
  end
end

def build_query(params)
  params.flat_map do |k, v|
    v.is_a?(Array) ? v.map { |x| "#{encode(k)}[]=#{encode(x.to_s)}" } : "#{encode(k)}=#{encode(v.to_s)}"
  end.join("&")
end

q = "q=ruby+on+rails&page=2&tags[]=web&tags[]=mvc&name=Jos%C3%A9&empty="
params = parse_query(q)
puts params.inspect
rebuilt = build_query(params)
puts rebuilt
puts parse_query(rebuilt) == params
puts build_query("msg" => "50% off & free!", "list" => [1, 2])
