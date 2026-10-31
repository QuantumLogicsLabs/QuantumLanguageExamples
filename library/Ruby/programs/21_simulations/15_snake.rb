# A scripted game of Snake.
WIDTH = 10
HEIGHT = 6
DIRS = { "U" => [-1, 0], "D" => [1, 0], "L" => [0, -1], "R" => [0, 1] }.freeze
food_cells = [[1, 7], [4, 7], [4, 2], [0, 0]]

snake = [[2, 2], [2, 1], [2, 0]]
food = food_cells.shift
score = 0
"RRRRRURRDDDLLLLLLLUUUULLDRU".each_char.with_index do |m, t|
  dy, dx = DIRS[m]
  head = [snake.first[0] + dy, snake.first[1] + dx]
  if !head[0].between?(0, HEIGHT - 1) || !head[1].between?(0, WIDTH - 1) || snake[0...-1].include?(head)
    puts "crashed at step #{t + 1} going #{m} into #{head.inspect}"
    break
  end
  snake.unshift(head)
  if head == food
    score += 1
    food = food_cells.shift
    puts "step #{t + 1}: ate food, length #{snake.size}"
  else
    snake.pop
  end
end

HEIGHT.times do |y|
  puts WIDTH.times.map { |x| snake.first == [y, x] ? "@" : snake.include?([y, x]) ? "o" : food == [y, x] ? "*" : "." }.join
end
puts "score #{score}"
