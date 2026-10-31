# Breaking URLs into parts with URI.
require "uri"

urls = [
  "https://user:secret@shop.example.com:8443/cart/items?id=42&sort=price#top",
  "http://example.org/",
  "ftp://files.example.net/pub/file.tar.gz"
]

urls.each do |u|
  uri = URI.parse(u)
  puts "#{uri.scheme} | #{uri.host} | #{uri.port} | #{uri.path} | #{uri.query.inspect} | #{uri.fragment.inspect}"
end

query = URI.parse(urls[0]).query
params = URI.decode_www_form(query).to_h
puts params.inspect
puts URI.encode_www_form(q: "ruby & rails", page: 2)
puts URI.encode_www_form_component("a b/c?d")
puts URI.decode_www_form_component("hello%20world%21")
base = URI("https://example.com/docs/guide/")
puts URI.join(base, "../api/index.html")
