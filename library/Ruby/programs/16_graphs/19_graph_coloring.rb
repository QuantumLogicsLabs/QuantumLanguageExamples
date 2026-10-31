# Greedy colouring for an exam timetable.
CONFLICTS = {
  "math" => %w[physics chem cs], "physics" => %w[math chem], "chem" => %w[math physics bio],
  "bio" => %w[chem], "cs" => %w[math art], "art" => %w[cs], "history" => []
}.freeze

def greedy_color(graph, order)
  colors = {}
  order.each do |node|
    used = graph[node].filter_map { |n| colors[n] }
    colors[node] = (0..).find { |c| !used.include?(c) }
  end
  colors
end

by_degree = CONFLICTS.keys.sort_by { |k| [-CONFLICTS[k].size, k] }
colors = greedy_color(CONFLICTS, by_degree)
colors.group_by { |_, c| c }.sort.each { |slot, exams| puts "Slot #{slot + 1}: #{exams.map(&:first).sort.join(', ')}" }
puts "valid: #{CONFLICTS.all? { |a, ns| ns.all? { |b| colors[a] != colors[b] } }}"
alpha = greedy_color(CONFLICTS, CONFLICTS.keys.sort)
puts "alphabetical order uses #{alpha.values.uniq.size} slots, degree order uses #{colors.values.uniq.size}"
