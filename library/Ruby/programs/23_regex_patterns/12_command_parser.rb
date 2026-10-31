# Parsing commands with pattern matching on split words.
def execute(line, state)
  case line.split
  in ["set", key, value] then state[key] = value.match?(/\A-?\d+\z/) ? value.to_i : value
  in ["get", key] then puts "#{key} = #{state.fetch(key, 'undefined').inspect}"
  in ["incr", key] then state[key] = state.fetch(key, 0) + 1
  in ["incr", key, /\A\d+\z/ => by] then state[key] = state.fetch(key, 0) + by.to_i
  in ["del", *keys] if keys.any? then keys.each { |k| state.delete(k) }
  in ["list"] then puts state.sort.map { |k, v| "#{k}=#{v}" }.join(" ")
  in [] then nil
  in [cmd, *] then puts "unknown or malformed: #{cmd}"
  end
end

state = {}
script = <<~CMD
  set name ruby
  set version 3
  incr version
  incr visits 10
  incr visits
  get version
  get missing
  list
  del name visits
  frobnicate now

  list
CMD
script.each_line { |l| execute(l.strip, state) }
