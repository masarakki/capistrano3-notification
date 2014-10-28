namespace :load do
  task :defaults do
    set :irc_port, 6667
    set :irc_user, 'capistrano'
    set :notification, -> { "#{fetch(:application)} was deployed to #{fetch(:stage)}" }
  end
end

namespace :notification do
  task :notify do
    %w(irc).each do |adapter|
      invoke "notification:#{adapter}"
    end
  end

  task :irc do
    require 'shout-bot'
    user = fetch(:irc_user)
    host = fetch(:irc_host)
    port = fetch(:irc_port)
    channel = fetch(:irc_channel)
    message = fetch(:notification)
    return unless user && host && port && channel && message
    url = "irc://#{user}@#{host}:#{port}/#{channel}"
    ShoutBot.shout(url) { |irc| irc.say message }
  end

  after 'deploy:finished', 'notification:notify'
end
