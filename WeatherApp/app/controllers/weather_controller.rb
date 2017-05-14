class WeatherController < ApplicationController
  def index
    @cities = "524901,703448,6058560,1819729,4321929"
    @lookup = Weather.call(@cities)
    @temp = Weather.max_value(Weather.make_hash(@lookup, "temp"))
    @pressure = Weather.max_value(Weather.make_hash(@lookup, "pressure"))
    @humidity = Weather.min_value(Weather.make_hash(@lookup, "humidity"))
    @clouds = Weather.min_value(Weather.cloud_hash(@lookup))
    @best = [@temp, @pressure, @humidity, @clouds]
  end
end
