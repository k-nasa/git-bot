task notify_task: :environment do
  c = BotController.new
  c.send(:urge_work)
end
