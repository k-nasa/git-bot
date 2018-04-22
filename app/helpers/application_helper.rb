module ApplicationHelper
  def fetch_github_contributions_data
    uri = URI.parse('https://github.com/users/k-nasa/contributions') # とりあえず自分ので固定
    Net::HTTP.get(uri)
  end

  def parse_github_contributions_data
    doc = Nokogiri::HTML.parse(fetch_github_contributions_data)
    doc = doc.xpath("//rect[@data-date='#{Date.today.to_s}']") # 今日の分に絞り込む
    doc = doc.first # データが１つだけのArrayになっているので最初だけを取り出す
    doc.attribute('data-count').value.to_i
  end
end
