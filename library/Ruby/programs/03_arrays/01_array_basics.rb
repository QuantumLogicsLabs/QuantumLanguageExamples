# Creating and changing arrays.
nums = [3, 1, 4]
nums.push(1)
nums << 5
nums.unshift(9)
puts nums.inspect
puts nums.pop
puts nums.shift
puts nums.inspect
nums.insert(2, 7, 7)
puts nums.inspect
nums.delete_at(0)
puts nums.inspect
nums.delete(7)
puts nums.inspect
puts nums.first, nums.last
puts nums.first(2).inspect
puts nums.size
puts nums.sum
puts nums.empty?
puts [].empty?
puts nums.reverse.inspect
puts nums.include?(4)
puts nums.count(1)
nums.clear
puts nums.inspect
