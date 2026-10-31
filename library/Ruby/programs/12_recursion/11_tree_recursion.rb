# Recursion over a nested hash tree.
org = {
  name: "CEO", salary: 300,
  reports: [
    { name: "CTO", salary: 250, reports: [
      { name: "Dev Lead", salary: 180, reports: [{ name: "Dev", salary: 120, reports: [] }, { name: "Dev", salary: 115, reports: [] }] },
      { name: "Ops Lead", salary: 170, reports: [] }
    ] },
    { name: "CFO", salary: 240, reports: [{ name: "Accountant", salary: 100, reports: [] }] }
  ]
}

def headcount(node) = 1 + node[:reports].sum { |r| headcount(r) }
def payroll(node) = node[:salary] + node[:reports].sum { |r| payroll(r) }
def depth(node) = 1 + (node[:reports].map { |r| depth(r) }.max || 0)
def leaves(node) = node[:reports].empty? ? [node[:name]] : node[:reports].flat_map { |r| leaves(r) }

def print_tree(node, indent = "")
  puts "#{indent}#{node[:name]} (#{node[:salary]})"
  node[:reports].each { |r| print_tree(r, indent + "  ") }
end

print_tree(org)
puts "Headcount: #{headcount(org)}"
puts "Payroll: #{payroll(org)}"
puts "Depth: #{depth(org)}"
puts "Leaves: #{leaves(org).inspect}"
