require 'json'
require 'uri'

class Session
  def initialize(req)
    cookie = req.cookies.select do |c|
      c.name == "_rails_lite_app"
    end.first

    @data = cookie.nil? ? {} : JSON.parse(cookie.value)
  end

  def [](key)
    @data[key]
  end

  def []=(key, val)
    @data[key] = val
  end

  def store_session(res)
    res.cookies << WEBrick::Cookie.new(
      "_rails_lite_app",
      @data.to_json
    )
  end
end

module Params
  def self.parse(req, route_params)
    params = {}
    params.merge!(route_params)
    params.merge!(self.parse_www_encoded_form(req.body))
    if req.query_string
      params.merge!(self.parse_www_encoded_form(req.query_string))
    end

    params
  end

  def self.parse_www_encoded_form(www_encoded_form)
    params = {}

    key_values = URI.decode_www_form(www_encoded_form)
    key_values.each do |full_key, value|
      scope = params

      key_seq = parse_key(full_key)
      key_seq.each_with_index do |key, idx|
        if (idx + 1) == key_seq.count
          scope[key] = value
        else
          scope[key] ||= {}
          scope = scope[key]
        end
      end
    end

    params
  end

  def self.parse_key(key)
    match_data = /(?<head>.*)\[(?<rest>.*)\]/.match(key)
    if match_data
      parse_key(match_data["rest"]).unshift(match_data["head"])
    else
      [key]
    end
  end
end

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params)
    @req = req
    @res = res

    @params = Params.parse(req, route_params)
  end

  def session
    @session ||= Session.new(@req)
  end

  def already_rendered?
    if @rendered.nil?
      false
    else
      @rendered
    end
  end

  def redirect_to(url)
    raise "double render" if already_rendered?

    @res.status = 302
    @res.header['location'] = url
    session.store_session(res)

    @rendered = true
    nil
  end

  def render_content(content, type)
    raise "double render error" if already_rendered?

    @res.content_type = type
    @res.body = content
    session.store_session(@res)

    @rendered = true
    nil
  end

  def render(template_name)
    template_fname =
      File.join("views", self.class.name.underscore, "#{template_name}.html.erb")
    render_content(
      ERB.new(File.read(template_fname)).result(binding),
      "text/html"
    )
  end

  def invoke_action(name)
    self.send(name)
    render(name) unless already_rendered?

    nil
  end

  # routing
end
