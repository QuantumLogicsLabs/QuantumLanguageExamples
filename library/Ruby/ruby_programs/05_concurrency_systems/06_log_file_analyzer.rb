# A small systems utility: parse a log file's lines, tally counts by
# log level, and pull out ERROR lines for review -- the kind of
# quick text-processing script you'd run against real server logs.
def analyze_log(lines)
  stats = Hash.new(0)
  errors = []

  lines.each do |line|
    if line =~ /\[(\w+)\]/
      level = $1
      stats[level] += 1
      errors << line if level == "ERROR"
    end
  end

  { counts: stats, errors: errors }
end

if __FILE__ == $0
  sample_log = <<~LOG
    [INFO] Server started on port 8080
    [DEBUG] Connection pool initialized
    [ERROR] Failed to connect to database
    [INFO] Retrying connection
    [WARN] High memory usage detected
    [ERROR] Timeout waiting for response
    [INFO] Connection established
  LOG

  result = analyze_log(sample_log.lines)
  puts "Log level counts: #{result[:counts]}"
  puts "Errors found:"
  result[:errors].each { |e| puts "  #{e.strip}" }
end
