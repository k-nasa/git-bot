Rails.application.routes.draw do
  post '/callback' => 'application#callback'
  get '/callback' => 'application#test'
end
