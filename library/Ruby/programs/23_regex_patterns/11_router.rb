# A URL router that matches patterns and extracts parameters.
class Router
  def initialize = @routes = []

  def add(method, pattern, name)
    keys = []
    regex = pattern.gsub(/:(\w+)/) { keys << $1.to_sym; "([^/]+)" }.gsub("*", "(.*)")
    keys << :splat if pattern.include?("*")
    @routes << [method, Regexp.new("\\A#{regex}\\z"), keys, name]
    self
  end

  def match(method, path)
    @routes.each do |m, regex, keys, name|
      next unless m == method
      md = regex.match(path) or next
      return [name, keys.zip(md.captures).to_h]
    end
    [:not_found, {}]
  end
end

router = Router.new
router.add("GET", "/", :home)
      .add("GET", "/users/:id", :show_user)
      .add("GET", "/users/:user_id/posts/:post_id", :show_post)
      .add("POST", "/users", :create_user)
      .add("GET", "/files/*", :file)

[["GET", "/"], ["GET", "/users/42"], ["GET", "/users/7/posts/99"], ["POST", "/users"],
 ["DELETE", "/users/42"], ["GET", "/files/docs/2024/report.pdf"], ["GET", "/nope"]].each do |m, path|
  name, params = router.match(m, path)
  puts "#{m.ljust(6)} #{path.ljust(28)} -> #{name} #{params.inspect}"
end
