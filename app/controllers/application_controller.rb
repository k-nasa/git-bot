class ApplicationController < ActionController::Base
  def callback
  end

  private

  def client
    @clinet ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

end
