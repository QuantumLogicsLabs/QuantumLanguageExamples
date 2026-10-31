# Resource handling with blocks and ensure.
class Connection
  attr_reader :log

  def initialize(name)
    @name = name
    @log = []
  end

  def open = @log << "open #{@name}"
  def close = @log << "close #{@name}"
  def query(sql) = sql.include?("DROP") ? raise(ArgumentError, "refused: #{sql}") : "rows for #{sql}"
end

def with_connection(name)
  conn = Connection.new(name)
  conn.open
  yield conn
ensure
  conn&.close
  puts conn.log.join(", ")
end

result = with_connection("main") { |c| c.query("SELECT 1") }
puts result

begin
  with_connection("audit") { |c| c.query("DROP TABLE users") }
rescue ArgumentError => e
  puts "Error: #{e.message}"
end
