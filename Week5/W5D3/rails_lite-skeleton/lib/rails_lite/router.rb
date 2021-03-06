require_relative 'url_helper'

class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name,
              :route_params

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern = pattern
    @http_method = http_method
    @controller_class = controller_class
    @action_name = action_name
    @route_params = {}
  end

  def matches?(req)
    request_method = req.request_method.downcase.to_sym
    return false unless http_method == request_method
    path = req.unparsed_uri
    if pattern.match(path)
      extract_params(path)
      true
    else
      false
    end
  end

  def run(req, res)
    controller = controller_class.new(req, res, route_params)
    controller.invoke_action(action_name)
  end

  def path
    path = pattern.to_s.delete("^")
    path.delete!("$")
  end

  def simple?
    !pattern.to_s.include?("(?<")
  end

  private

    def extract_params(path)
      data = pattern.match(path)
      keys = data.names
      #This should extract the post match data, but doesn't
      # vals = [data.post_match]

      # keys.each_index do |hash_i|
      #   route_params[keys[hash_i]] = vals[hash_i]
      # end

      #This is the hack I'm using to make this work
      keys.each do |key|
        shared_parts = pattern.to_s.split("?<#{keys.first}>")
        val = path

        shared_parts.each do |part|
          val = val.delete(part)
        end

        route_params[key.to_sym] = val
      end
    end
end

class Router
  attr_reader :routes
  include UrlHelper

  def initialize
    @routes = []
  end

  def add_route(pattern, method, controller_class, action_name)
    route = Route.new(pattern, method, controller_class, action_name)
    @routes << route
    if route.simple?
      create_simple_url_helpers(route.path)
    end
  end

  def draw(&proc)
    self.instance_eval(&proc)
  end

  [:get, :post, :put, :delete].each do |http_method|
    # add these helpers in a loop here
    define_method(http_method) do |pattern, controller, action|
      add_route(pattern, http_method, controller, action)
    end
  end

  def match(req)
    routes.each do |route|
      return route if route.matches?(req)
    end
    nil
  end

  def run(req, res)
    route = match(req)
    if route
      route.run(req, res)
    else
      res.status = 404
    end
  end
end
