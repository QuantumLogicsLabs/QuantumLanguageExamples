# A minimal TCP echo server and client using Ruby's socket library --
# each connection is handled on its own thread, and the client sends
# a few lines to prove round-trip communication works.
require 'socket'

def start_echo_server(port)
  server = TCPServer.new('127.0.0.1', port)
  Thread.new do
    loop do
      client = server.accept
      Thread.new(client) do |conn|
        while (line = conn.gets)
          conn.puts("echo: #{line.strip}")
        end
        conn.close
      end
    end
  end
  server
end

if __FILE__ == $0
  port = 4481
  server = start_echo_server(port)
  sleep 0.1 # let the server start

  socket = TCPSocket.new('127.0.0.1', port)
  ["hello", "world", "ruby sockets"].each do |msg|
    socket.puts(msg)
    puts socket.gets.strip
  end
  socket.close
  server.close
end
