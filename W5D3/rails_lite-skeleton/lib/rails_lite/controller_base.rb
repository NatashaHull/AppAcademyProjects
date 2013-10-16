require 'erb'
require 'active_support/core_ext'
require_relative 'params'
require_relative 'session'

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params={})
    @req, @res, @route_params = req, res, route_params
  end

  def session
    @session ||= Session.new(@req)
  end

  def already_rendered?
    @already_built_response
  end

  def redirect_to(url)
    if already_rendered?
      raise RuntimeError, "Request has already been made"
    end
    base_url = url.split("http://www.").last
    @res.status = 302
    @res['location'] = "http://www.#{base_url}"
    @already_built_response = true
    session.store_session(@res)
  end

  def render_content(content, type)
    @res.content_type = type
    @res.body = content
    @already_built_response = true
    session.store_session(@res)
  end

  def render(template_name)
    if already_rendered?
      raise RuntimeError, "Request has already been made"
    end
    controller_name = self.class.to_s.underscore
    file_path = "views/#{controller_name}/#{template_name}.html.erb"
    template = File.read(file_path)
    content = ERB.new(template).result(binding)
    render_content(content, 'text/html')
  end

  def invoke_action(name)
  end
end
