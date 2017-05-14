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

  #create a hash to store city : temp values 
  def self.make_hash list, value
    hash = Hash.new
      list.each do |l|
        temp = l["main"][value]
        city = l["name"]
        hash[city] = temp
      end
    return hash
  end

  #create hash with city: cloud cover
  def self.cloud_hash list
    hash = Hash.new
      list.each do |l|
        cloud = l["clouds"]["all"]
        city = l["name"]
        hash[city] = cloud
      end
    return hash
  end

  #returns the highest value from a hash
  def self.max_value hash
    hash.max_by{|k,v| v}
  end  

  #returns the lowest value from a hash
  def self.min_value hash
    hash.min_by{ |k,v| v}
  end    

end  
