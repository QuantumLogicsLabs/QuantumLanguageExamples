# Planning semesters from course prerequisites.
PREREQS = {
  "Calc1" => [], "Calc2" => ["Calc1"], "LinAlg" => ["Calc1"], "Prog1" => [], "Prog2" => ["Prog1"],
  "DataStruct" => %w[Prog2 Discrete], "Discrete" => [], "Algorithms" => %w[DataStruct Calc2],
  "ML" => %w[LinAlg Algorithms Stats], "Stats" => ["Calc2"]
}.freeze

def semesters(prereqs, max_per_term)
  done = []
  plan = []
  until done.size == prereqs.size
    ready = prereqs.keys.select { |c| !done.include?(c) && (prereqs[c] - done).empty? }.sort
    raise "cycle in prerequisites" if ready.empty?
    term = ready.first(max_per_term)
    plan << term
    done.concat(term)
  end
  plan
end

semesters(PREREQS, 3).each_with_index { |term, i| puts "Term #{i + 1}: #{term.join(', ')}" }
puts "With 2 per term: #{semesters(PREREQS, 2).size} terms"
