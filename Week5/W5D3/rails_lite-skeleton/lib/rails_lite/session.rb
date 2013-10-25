require 'json'
require 'webrick'

class Session
  def initialize(req)
    @req = req
    find_cookies
  end

  def [](key)
    @session[key]
  end

  def []=(key, val)
    @session[key] = val
  end

  def store_session(res)
    name = "_rails_lite_app"
    value = @session.to_json
    cookie = WEBrick::Cookie.new(name, value)
    res.cookies << cookie
  end

  private
    def find_cookies
      @req.cookies.each do |cookie|
        if cookie.name == '_rails_lite_app'
          @session = JSON.parse(cookie.value)
        end
      end
      @session ||= {}
    end
end
