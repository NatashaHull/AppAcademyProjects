# API Key AIzaSyBpQgot5ZXD0VP4lOkC4ta9hWw-ixXEwWg
require 'json'
require 'rest-client'
require 'addressable/uri'
require 'nokogiri'

#Take current location in the form of an address.
input = "1061 Market St., San Francisco, CA"
current_address = input.gsub(' ', '+')

#Example address
#http://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&sensor=true_or_false
current_address_url = Addressable::URI.new(
   :scheme => "http",
   :host => "maps.googleapis.com",
   :path => "maps/api/geocode/json",
   :query_values => {:address => "#{current_address}",
                    :sensor => "false"}
 ).to_s

#Take location, send to GEOCODING API, to receieve a GPS latlong pair.
gps_location_raw = RestClient.get(current_address_url)
gps_location_json = JSON.parse(gps_location_raw)

gps_location = gps_location_json['results'].first['geometry']['location']

#Take GPS pair AND search string )ice cream, send to PLACES API and get array of
#closest ice cream shops and information about them.
search_url = Addressable::URI.new(
   :scheme => "https",
   :host => "maps.googleapis.com",
   :path => "maps/api/place/nearbysearch/json",
   :query_values =>
     {:key => "AIzaSyBpQgot5ZXD0VP4lOkC4ta9hWw-ixXEwWg",
      :location => "#{gps_location['lat']},#{gps_location['lng']}",
      :sensor => "false",
      :radius => 800,
      :keyword => "ice cream"
      }
 ).to_s

places_raw = RestClient.get(search_url)
places_json = JSON.parse(places_raw)

places = places_json["results"].map do |result|
  [result['geometry']["location"], result['name']]
end

#For each place, Get WALKING directions to the location from current gps latlong.

places.each do |result|
  p result[1]

  directions_url = Addressable::URI.new(
     :scheme => "http",
     :host => "maps.googleapis.com",
     :path => "maps/api/directions/json",
     :query_values => {:origin => "#{gps_location['lat']},#{gps_location['lng']}",
                      :destination => "#{result[0]['lat']},#{result[0]['lng']}",
                      :sensor => "false",
                      :mode => "walking"}
   ).to_s

  directions_raw = RestClient.get(directions_url)
  directions_json = JSON.parse(directions_raw)
  steps_array = directions_json["routes"].first["legs"].first["steps"]

  directions = steps_array.map do |step|
    direction_html = step["html_instructions"]
    Nokogiri::HTML(direction_html).text
  end

  p directions.join(". ")
end