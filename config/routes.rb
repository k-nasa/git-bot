Rails.application.routes.draw do
  post '/callback' => 'bot#callback'
  get '/callback' => 'bot#test'
end
