# A tiny template engine with variables, loops and conditionals.
class Template
  def initialize(src) = @src = src

  def render(ctx)
    out = @src.gsub(/\{\{#each (\w+)\}\}(.*?)\{\{\/each\}\}/m) do
      items = ctx.fetch(Regexp.last_match(1).to_sym, [])
      body = Regexp.last_match(2)
      items.map { |item| Template.new(body).render(ctx.merge(item)) }.join
    end
    out = out.gsub(/\{\{#if (\w+)\}\}(.*?)\{\{\/if\}\}/m) { ctx[Regexp.last_match(1).to_sym] ? Regexp.last_match(2) : "" }
    out.gsub(/\{\{(\w+)\}\}/) { ctx.fetch(Regexp.last_match(1).to_sym, "?").to_s }
  end
end

page = Template.new(<<~TPL)
  Hello {{name}}!
  {{#if vip}}You are a VIP member.
  {{/if}}Your orders:
  {{#each orders}}  - {{item}} x{{qty}}
  {{/each}}Total items: {{count}}
TPL

orders = [{ item: "pen", qty: 3 }, { item: "notebook", qty: 1 }]
puts page.render(name: "Ana", vip: true, orders: orders, count: orders.sum { |o| o[:qty] })
puts page.render(name: "Ben", vip: false, orders: [], count: 0)
