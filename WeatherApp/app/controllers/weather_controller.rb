class WeatherController < ApplicationController
  def index
    @cities = "524901,703448,6058560,1819729,4321929"
    @lookup = Weather.call(@cities)
  end
end
