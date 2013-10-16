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

  private

    def extract_params
    end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  def add_route(pattern, method, controller_class, action_name)
    route = Route.new(pattern, method, controller_class, action_name)
    @routes << route
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
