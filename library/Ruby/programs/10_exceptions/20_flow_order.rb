# Tracing begin/rescue/else/ensure for success and failure.
def run(label, fail:)
  trace = []
  begin
    trace << "body"
    raise "failure" if fail
    trace << "body done"
  rescue => e
    trace << "rescue(#{e.message})"
  else
    trace << "else"
  ensure
    trace << "ensure"
  end
  puts "#{label}: #{trace.join(' -> ')}"
end

run("success", fail: false)
run("failure", fail: true)

attempts = 0
begin
  attempts += 1
  raise "try again" if attempts < 3
  puts "succeeded after #{attempts} attempts"
rescue
  retry
end
