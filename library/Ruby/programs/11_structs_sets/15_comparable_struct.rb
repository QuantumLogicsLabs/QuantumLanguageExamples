# Structs that compare and sort naturally.
SemVer = Struct.new(:major, :minor, :patch) do
  include Comparable
  def self.parse(s) = new(*s.split(".").map(&:to_i))
  def <=>(other) = to_a <=> other.to_a
  def to_s = to_a.join(".")
  def bump(part)
    case part
    when :major then SemVer.new(major + 1, 0, 0)
    when :minor then SemVer.new(major, minor + 1, 0)
    else SemVer.new(major, minor, patch + 1)
    end
  end
end

versions = %w[1.4.2 1.10.0 0.9.9 1.4.10 2.0.0].map { |v| SemVer.parse(v) }
puts versions.sort.join(" < ")
puts versions.max
v = SemVer.parse("1.4.2")
puts [:patch, :minor, :major].map { |p| v.bump(p).to_s }.inspect
puts v.between?(SemVer.parse("1.0.0"), SemVer.parse("2.0.0"))
puts SemVer.parse("1.4.10") > SemVer.parse("1.4.9")
