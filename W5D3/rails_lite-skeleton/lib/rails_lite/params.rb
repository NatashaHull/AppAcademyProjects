require 'uri'

class Params
  def initialize(req, route_params)
    @req = req
    @params = route_params
    add_elements_to_params
  end

  def [](key)
    @params[key]
  end

  def to_s
    @params.to_json
  end

  private
    def parse_www_encoded_form(www_encoded_form)
      params = URI::decode_www_form(www_encoded_form)
      params.each do |key, val|
        parse_key(key, val)
      end
    end

    def add_elements_to_params
      if @req.body
        parse_www_encoded_form(@req.body)
      elsif @req.unparsed_uri.include?('?')
        unparsed_uri = req.unparsed_uri.split('?').last
        parse_www_encoded_form(unparsed_uri)
      end
    end

    def parse_key(key, val)
      different_keys = key.split(/\]\[|\[|\]/)
      if different_keys.length == 1
        #If there's only one key, then set the params hash accordingly
        @params[key] = val
      else
        #If there are nested keys, build out the params hash
        current_hash = @params
        different_keys.each_with_index do |k, key_i|
          if (key_i == different_keys.length-1)
            current_hash[k] = val
          else  
            current_hash[k] ||= {}
            current_hash = current_hash[k]
          end
        end
      end
    end
end
