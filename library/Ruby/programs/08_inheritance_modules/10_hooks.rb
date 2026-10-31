# included, extended and inherited callbacks.
module Plugin
  def self.registry = @registry ||= []

  def self.included(base)
    registry << base.name
    base.extend(ClassMethods)
  end

  module ClassMethods
    def plugin_name(name = nil)
      name ? @plugin_name = name : (@plugin_name || self.name.downcase)
    end
  end
end

module Greeting
  def self.extended(obj) = puts("extended #{obj.inspect}")
  def hello = "hello from #{self}"
end

class Base
  def self.inherited(sub)
    super
    (@subclasses ||= []) << sub.name
  end

  def self.subclass_names = @subclasses
end

class Exporter < Base
  include Plugin
  plugin_name "csv-export"
end

class Importer < Base
  include Plugin
end

puts Plugin.registry.inspect
puts Exporter.plugin_name
puts Importer.plugin_name
puts Base.subclass_names.inspect
obj = "target"
obj.extend(Greeting)
puts obj.hello
