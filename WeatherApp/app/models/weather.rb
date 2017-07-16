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

  #looks at the city name strings in the best weather group
  #an array of hashes
  def self.compare_city list
    city_names = Array.new
    list.each do |l|
        #gets the zeroth element of the array
        #extracts the city names
        names = l[0]
        city_names.push(names)
    end
    #return most occuring city name in group 
    #need to add an exception here to check for no re-occuring values
    return city_names.group_by(&:to_s).values.max_by(&:size).try(:first)
  end 
end  
