require 'uri'

class Params
  def initialize(req, route_params)
    @req, @route_params = req, route_params
    @params = {}
  end

  def [](key)
    @params[key]
  end

  def to_s
  end

  private
    def parse_www_encoded_form(www_encoded_form)
      params = URI::decode_www_form(www_encoded_form)
      params.each do |key, val|
        @params[key] = val
      end
    end

    def parse_key(key)
    end
end
