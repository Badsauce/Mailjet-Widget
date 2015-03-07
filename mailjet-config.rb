Mailjet.configure do |config|
  config.api_key = ENV['MJ_KEY'].strip
  config.secret_key = ENV['MJ_SECRET'].strip
end
