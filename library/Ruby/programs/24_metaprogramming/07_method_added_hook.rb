# Reacting to method definitions with method_added.
module Documented
  def self.extended(base) = base.instance_variable_set(:@docs, {})

  def doc(text) = @pending_doc = text
  def docs = @docs

  def method_added(name)
    super
    return unless @pending_doc
    @docs[name] = @pending_doc
    @pending_doc = nil
  end
end

class Api
  extend Documented

  doc "Returns the current status"
  def status = "ok"

  def internal = "undocumented"

  doc "Echoes its argument"
  def echo(x) = x
end

Api.docs.each { |m, d| puts "#{m}: #{d}" }
puts Api.new.echo("hi")
undocumented = Api.public_instance_methods(false) - Api.docs.keys
puts "undocumented: #{undocumented.inspect}"
