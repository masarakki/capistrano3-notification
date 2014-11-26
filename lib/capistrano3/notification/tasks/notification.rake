namespace :load do
  task :defaults do
    set :irc_port, 6667
    set :irc_user, 'capistrano'
    set :slack_user, 'capistrano'
    set :notification, -> { "#{fetch(:application)} was deployed to #{fetch(:stage)}" }
  end
end

namespace :notification do
  task :notify do
    %w(irc slack).each do |adapter|
      invoke "notification:#{adapter}"
    end
  end

  task :irc do
    user = fetch(:irc_user)
    host = fetch(:irc_host)
    port = fetch(:irc_port)
    channel = fetch(:irc_channel)
    message = fetch(:notification)
    return unless user && host && port && channel && message
    require 'shout-bot'
    url = "irc://#{user}@#{host}:#{port}/#{channel}"
    ShoutBot.shout(url) { |irc| irc.say message }
  end

  task :slack do
    webhook_url = fetch(:slack_webhook_url)
    name = fetch(:slack_user) || nil
    channel = fetch(:slack_channel) || nil
    icon = fetch(:slack_icon) || nil
    message = fetch(:notification)
    return unless webhook_url && message
    require 'slack-notifier'
    notifier_options = { username: name, channel: channel }.reject { |_x, y| y.nil? }
    icon_type = case icon
                when /^:.+:/
                  :icon_emoji
                when /^http/
                  :icon_url
                else
                  nil
                end
    ping_options = {}.tap do |h|
      h[icon_type] = icon if icon_type
    end
    notifier = Slack::Notifier.new webhook_url, notifier_options
    notifier.ping message, ping_options
  end

  after 'deploy:finished', 'notification:notify'
end
