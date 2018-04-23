class BotController < ApplicationController
  require 'line/bot'

  protect_from_forgery except: [:callback]

  def test
    render plain: 'hgeohgoe'
  end

  def callback
    req_body = request.body.read
    events = client.parse_events_from(req_body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        test_message = { type: :text, text: event.message['text'] }
        client.reply_message(event['replyToken'], test_message)
      end
    end
  end

  private

  def client
    @clinet ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end
end
