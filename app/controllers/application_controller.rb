class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def callback
  end
end