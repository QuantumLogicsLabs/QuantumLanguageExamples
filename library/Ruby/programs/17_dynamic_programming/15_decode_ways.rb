# Counting decodings of digit strings (A=1 ... Z=26).
def decode_count(s)
  return 0 if s.empty? || s.start_with?("0")
  prev2, prev1 = 1, 1
  (1...s.size).each do |i|
    cur = 0
    cur += prev1 unless s[i] == "0"
    cur += prev2 if (10..26).cover?(s[i - 1, 2].to_i)
    prev2, prev1 = prev1, cur
  end
  prev1
end

def decodings(s)
  return [""] if s.empty?
  out = []
  (1..2).each do |len|
    next if len > s.size || s[0] == "0"
    v = s[0, len].to_i
    next if v > 26
    decodings(s[len..]).each { |rest| out << (64 + v).chr + rest }
  end
  out
end

%w[12 226 06 11106 2101 1111111111].each do |s|
  list = decodings(s)
  puts "#{s}: #{decode_count(s)} #{list.size <= 8 ? list.inspect : "(#{list.size} decodings)"}"
end
