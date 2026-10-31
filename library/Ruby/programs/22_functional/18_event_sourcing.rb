# Rebuilding account state by folding over events.
EVENTS = [
  { type: :opened, owner: "Ana", at: 1 },
  { type: :deposited, amount: 100, at: 2 },
  { type: :withdrew, amount: 30, at: 3 },
  { type: :deposited, amount: 45, at: 5 },
  { type: :frozen, at: 6 },
  { type: :withdrew, amount: 500, at: 7 },
  { type: :unfrozen, at: 8 },
  { type: :withdrew, amount: 15, at: 9 }
].freeze

def apply(state, e)
  case e
  in { type: :opened, owner: }
    { owner: owner, balance: 0, frozen: false, history: [] }
  in { type: :deposited, amount: } unless state[:frozen]
    state.merge(balance: state[:balance] + amount, history: state[:history] + ["+#{amount}"])
  in { type: :withdrew, amount: } if !state[:frozen] && amount <= state[:balance]
    state.merge(balance: state[:balance] - amount, history: state[:history] + ["-#{amount}"])
  in { type: :frozen } then state.merge(frozen: true)
  in { type: :unfrozen } then state.merge(frozen: false)
  else state.merge(history: state[:history] + ["rejected #{e[:type]} at #{e[:at]}"])
  end
end

final = EVENTS.reduce({}) { |s, e| apply(s, e) }
puts final.inspect
puts "balance at t=4: #{EVENTS.take_while { |e| e[:at] <= 4 }.reduce({}) { |s, e| apply(s, e) }[:balance]}"
snapshots = EVENTS.each_with_object([{}]) { |e, acc| acc << apply(acc.last, e) }.drop(1)
puts snapshots.map { |s| s[:balance] }.inspect
