# A configuration DSL evaluated with instance_eval.
class Config
  def self.define(&block) = new.tap { |c| c.instance_eval(&block) }

  def initialize = @data = {}

  def set(key, value) = @data[key] = value

  def group(name, &block)
    sub = Config.define(&block)
    @data[name] = sub.to_h
  end

  def env(name)
    yield if name == :production
  end

  def to_h = @data
end

config = Config.define do
  set :app_name, "shop"
  set :workers, 4
  group :database do
    set :host, "localhost"
    set :pool, 10
  end
  group :cache do
    set :ttl, 60
  end
  env(:production) { set :workers, 16 }
  env(:test) { set :workers, 1 }
end

def show(hash, indent = 0)
  hash.each do |k, v|
    if v.is_a?(Hash)
      puts "#{'  ' * indent}#{k}:"
      show(v, indent + 1)
    else
      puts "#{'  ' * indent}#{k} = #{v.inspect}"
    end
  end
end
show(config.to_h)
