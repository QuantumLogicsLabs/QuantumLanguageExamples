# Word Break: can a string be segmented into dictionary words? Plus a
# memoized variant that returns every valid segmentation as a sentence.
def word_break?(s, word_dict)
  n = s.length
  dp = Array.new(n + 1, false)
  dp[0] = true

  (1..n).each do |i|
    (0...i).each do |j|
      if dp[j] && word_dict.include?(s[j...i])
        dp[i] = true
        break
      end
    end
  end
  dp[n]
end

def word_break_all(s, word_dict)
  n = s.length
  memo = {}

  solve = lambda do |start|
    return [""] if start == n
    return memo[start] if memo.key?(start)

    sentences = []
    (start + 1..n).each do |endi|
      word = s[start...endi]
      next unless word_dict.include?(word)
      solve.call(endi).each do |rest|
        sentences << (rest.empty? ? word : "#{word} #{rest}")
      end
    end
    memo[start] = sentences
  end

  solve.call(0)
end

if __FILE__ == $0
  dict = %w[leet code sand and cat cats dog sand dogs]
  puts "'leetcode' breakable? #{word_break?('leetcode', dict)}"
  puts "'catsanddog' breakable? #{word_break?('catsanddog', dict)}"
  puts "All sentences for 'catsanddog': #{word_break_all('catsanddog', dict)}"
end
