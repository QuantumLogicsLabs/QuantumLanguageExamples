# The order in which bodies, rescues and ensures run.
def step(log, name)
  log << "enter #{name}"
  yield if block_given?
ensure
  log << "leave #{name}"
end

log = []
begin
  step(log, "outer") do
    step(log, "middle") do
      step(log, "inner") { raise "boom" }
    end
  end
rescue => e
  log << "rescued #{e.message}"
end
puts log

def returns_from_ensure_test
  return "from body"
ensure
  puts "ensure ran before the return value was used"
end
puts returns_from_ensure_test
