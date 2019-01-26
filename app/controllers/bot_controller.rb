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

    head :ok
  end

  private

  def client
    @clinet ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

  def fetch_github_contributions_data
    uri = URI.parse('https://github.com/users/k-nasa/contributions') # とりあえず自分ので固定
    Net::HTTP.get(uri)
  end

  def github_contributions_data
    doc = Nokogiri::HTML.parse(fetch_github_contributions_data)
    doc = doc.xpath("//rect[@data-date='#{Time.zone.today.to_s}']")
    doc = doc.first
    doc.attribute('data-count').value.to_i
  end

  def urge_work
    client.push_message(USERID, { type: :text, text: '今日は怠けますか？' }) if github_contributions_data.zero?
  end
end
