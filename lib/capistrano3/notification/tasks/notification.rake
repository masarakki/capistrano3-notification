namespace :load do
  task :defaults do
    set :irc_port, 6667
    set :notifier, 'capistrano'
    set :notification, -> { "#{fetch(:application)} was deployed to #{fetch(:stage)}" }
  end
end

namespace :notification do
  task :notify do
    deprecated :irc_user, :notifier if fetch(:irc_user)
    deprecated :slack_user, :notifier if fetch(:slack_user)

    %w(irc slack).each do |adapter|
      invoke "notification:#{adapter}"
    end
  end

  task :irc do
    user = fetch(:irc_user) || fetch(:notifier)
    host = fetch(:irc_host)
    port = fetch(:irc_port)
    channel = fetch(:irc_channel)
    message = fetch(:notification)
    next unless user && host && port && channel && message
    require 'shout-bot'
    url = "irc://#{user}@#{host}:#{port}/#{channel}"
    ShoutBot.shout(url) { |irc| irc.say message }
  end

  task :slack do
    webhook_url = fetch(:slack_webhook_url)
    user =  fetch(:slack_user) || fetch(:notifier)
    channel = fetch(:slack_channel)
    icon = fetch(:slack_icon) || nil
    message = fetch(:notification)
    next unless user && channel && webhook_url && message
    require 'slack-notifier'
    notifier_options = { username: user, channel: channel }.reject { |_x, y| y.nil? }
    icon_type = case icon
                when /^:.+:/
                  :icon_emoji
                when /^http/
                  :icon_url
                end
    ping_options = {}.tap do |h|
      h[icon_type] = icon if icon_type
    end
    notifier = Slack::Notifier.new webhook_url, notifier_options
    notifier.ping message, ping_options
  end

  def deprecated(old, new)
    puts format('%6s %s', 'WARN'.red, ":#{old} is deplicated. use set :#{new}, '#{fetch(old)}'")
  end

  after 'deploy:finished', 'notification:notify'
end
