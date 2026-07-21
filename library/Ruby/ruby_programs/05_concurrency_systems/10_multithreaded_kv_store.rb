# A tiny in-memory key-value store, protected by a Mutex so multiple
# threads can safely SET/GET/DEL/KEYS concurrently -- the core of a
# toy Redis-like server.
require 'thread'

class KVStore
  def initialize
    @data = {}
    @lock = Mutex.new
  end

  def get(key)
    @lock.synchronize { @data[key] }
  end

  def set(key, value)
    @lock.synchronize { @data[key] = value }
  end

  def delete(key)
    @lock.synchronize { @data.delete(key) }
  end

  def keys
    @lock.synchronize { @data.keys }
  end
end

def handle_command(store, command)
  parts = command.strip.split(' ', 3)
  case parts[0]&.upcase
  when 'SET'
    store.set(parts[1], parts[2])
    "OK"
  when 'GET'
    store.get(parts[1]) || "(nil)"
  when 'DEL'
    store.delete(parts[1])
    "OK"
  when 'KEYS'
    store.keys.join(', ')
  else
    "ERROR unknown command"
  end
end

if __FILE__ == $0
  store = KVStore.new
  commands = ["SET name ruby", "SET lang gem", "GET name", "KEYS", "DEL lang", "KEYS"]

  threads = commands.map do |cmd|
    Thread.new { puts "#{cmd.ljust(20)} => #{handle_command(store, cmd)}" }
  end
  threads.each(&:join)
end
