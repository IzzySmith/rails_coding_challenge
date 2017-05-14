Rails.application.routes.draw do
  get 'weather/index'

  root 'weather#index'
end
