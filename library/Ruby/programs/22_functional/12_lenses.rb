# Lenses for reading and updating nested immutable hashes.
Lens = Struct.new(:getter, :setter) do
  def get(obj) = getter.(obj)
  def set(obj, value) = setter.(obj, value)
  def over(obj, &f) = set(obj, f.(get(obj)))
  def >>(other) = Lens.new(->(o) { other.get(get(o)) }, ->(o, v) { set(o, other.set(get(o), v)) })
end

def key(k) = Lens.new(->(h) { h.fetch(k) }, ->(h, v) { h.merge(k => v) })
def index(i) = Lens.new(->(a) { a[i] }, ->(a, v) { a.dup.tap { |c| c[i] = v } })

state = { user: { name: "ana", tags: %w[admin dev], prefs: { theme: "dark" } } }.freeze
name = key(:user) >> key(:name)
theme = key(:user) >> key(:prefs) >> key(:theme)
second_tag = key(:user) >> key(:tags) >> index(1)

puts name.get(state)
s2 = name.over(state, &:capitalize)
s3 = theme.set(s2, "light")
s4 = second_tag.set(s3, "ops")
puts s4.inspect
puts state.inspect
puts state[:user][:prefs].equal?(s2[:user][:prefs])
