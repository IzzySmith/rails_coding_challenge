class Weather
  include HTTParty
  
  base_uri "http://api.openweathermap.org/data/2.5/group?appid=4122e656dc75ed86c90dde6ba95fbcd1"
  format :json

  #call the api with HTTParty and parse the JSON response 
  def self.call list_ids
    response = HTTParty.get(base_uri + '&id=' + list_ids)
    body = JSON.parse(response.body)
    list = body["list"]
  end

end  
