# Translating low-level errors at each layer.
class StorageError < StandardError; end
class ServiceError < StandardError; end

def storage_read(key)
  data = { "a" => "1", "b" => "oops" }
  data.fetch(key)
rescue KeyError => e
  raise StorageError, "no such key #{key}"
end

def service_value(key)
  Integer(storage_read(key))
rescue StorageError => e
  raise ServiceError, "lookup failed: #{e.message}"
rescue ArgumentError
  raise ServiceError, "corrupt value for #{key}"
end

%w[a b c].each do |k|
  puts "#{k}: #{service_value(k)}"
rescue ServiceError => e
  chain = []
  err = e
  while err
    chain << "#{err.class}(#{err.message})"
    err = err.cause
  end
  puts "#{k}: #{chain.join(' <- ')}"
end
