# Turning titles into URL slugs, with collisions handled.
TRANSLIT = { "ä" => "ae", "ö" => "oe", "ü" => "ue", "ß" => "ss", "é" => "e", "è" => "e", "à" => "a", "ç" => "c", "ñ" => "n" }.freeze

def slugify(title)
  title.downcase
       .gsub(/[äöüßéèàçñ]/) { |c| TRANSLIT[c] }
       .gsub(/[^a-z0-9]+/, "-")
       .gsub(/\A-+|-+\z/, "")
end

def unique_slugs(titles)
  seen = Hash.new(0)
  titles.map do |t|
    base = slugify(t)
    seen[base] += 1
    seen[base] == 1 ? base : "#{base}-#{seen[base]}"
  end
end

titles = ["Hello, World!", "  Ruby 3.4 Released  ", "Crème Brûlée Recipe", "Größe & Maß", "Hello World",
          "hello-world", "Señor Café --- à la carte"]
titles.zip(unique_slugs(titles)).each { |t, s| puts "#{t.inspect.ljust(30)} -> #{s}" }
