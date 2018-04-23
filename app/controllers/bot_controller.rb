class BotController < ApplicationController
  require 'line/bot'

  protect_from_forgery except: [:callback]
  USERID = 'Ucb394d258cf3ea084cddfa544fd05382' # とりあえず自分の固定

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

    head :ok # 応答ステータスに200を設定
  end

  private

  def client
    @clinet ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

  def urge_work
    client.push(USERID, { type: :text, message: '今日は怠けますか？' }) unless github_contributions_data.zero?
  end
end
