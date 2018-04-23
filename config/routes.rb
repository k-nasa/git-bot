Rails.application.routes.draw do
  post '/callback' => 'bot#callback'
end
