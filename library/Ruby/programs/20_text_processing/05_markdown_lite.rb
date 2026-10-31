# Converting a subset of Markdown to HTML.
def inline(text)
  text.gsub(/\*\*(.+?)\*\*/, '<strong>\1</strong>')
      .gsub(/\*(.+?)\*/, '<em>\1</em>')
      .gsub(/`(.+?)`/, '<code>\1</code>')
      .gsub(/\[(.+?)\]\((.+?)\)/, '<a href="\2">\1</a>')
end

def markdown(src)
  html = []
  in_list = false
  src.each_line(chomp: true) do |line|
    if line.start_with?("- ")
      html << "<ul>" unless in_list
      in_list = true
      html << "  <li>#{inline(line[2..])}</li>"
      next
    end
    if in_list
      html << "</ul>"
      in_list = false
    end
    case line
    when /\A(#+) (.*)/ then html << "<h#{$1.size}>#{inline($2)}</h#{$1.size}>"
    when "" then next
    else html << "<p>#{inline(line)}</p>"
    end
  end
  html << "</ul>" if in_list
  html.join("\n")
end

puts markdown(<<~MD)
  # Release notes
  Version **2.0** is *finally* here.
  ## Changes
  - New `parse` method
  - Faster [docs](https://example.com/docs)
  - **Breaking:** removed `old_api`

  Thanks for reading!
MD
