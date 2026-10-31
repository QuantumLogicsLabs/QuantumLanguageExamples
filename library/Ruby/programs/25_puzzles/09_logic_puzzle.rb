# A small logic puzzle solved by trying all assignments.
# Three friends (Ana, Ben, Cy) each own a different pet (cat, dog, fish)
# and live in houses 1-3. Clues:
#   1. Ana does not own the dog.
#   2. The cat owner lives in house 1.
#   3. Ben lives next to the fish owner.
#   4. Cy lives in a higher-numbered house than Ana.
#   5. The dog owner does not live in house 3.
people = %w[Ana Ben Cy]
solutions = []
%w[cat dog fish].permutation.each do |pets|
  [1, 2, 3].permutation.each do |houses|
    pet = people.zip(pets).to_h
    house = people.zip(houses).to_h
    owner = pet.invert
    next if pet["Ana"] == "dog"
    next unless house[owner["cat"]] == 1
    next unless (house["Ben"] - house[owner["fish"]]).abs == 1
    next unless house["Cy"] > house["Ana"]
    next if house[owner["dog"]] == 3
    solutions << people.map { |p| "#{p}: #{pet[p]} in house #{house[p]}" }
  end
end
puts "#{solutions.size} solution(s)"
solutions.each { |s| puts s; puts }
