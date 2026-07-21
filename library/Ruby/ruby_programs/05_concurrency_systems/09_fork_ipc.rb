# Process-level parallelism: fork a child process and communicate
# with it over an IO.pipe, the classic Unix inter-process
# communication (IPC) mechanism.
if __FILE__ == $0
  if Process.respond_to?(:fork)
    reader, writer = IO.pipe

    pid = fork do
      reader.close
      5.times { |i| writer.puts("message #{i} from child (pid=#{Process.pid})") }
      writer.close
    end

    writer.close
    while (line = reader.gets)
      puts "[parent received] #{line.strip}"
    end
    reader.close

    Process.wait(pid)
    puts "Child process #{pid} finished."
  else
    puts "fork is not supported on this platform."
  end
end
