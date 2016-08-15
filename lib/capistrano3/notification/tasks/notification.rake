namespace :load do
  task :defaults do
    set :irc_port, 6667
    set :notifier, 'capistrano'
    set :notification, -> { "#{fetch(:application)} was deployed to #{fetch(:stage)}" }
  end
end

namespace :notification do
  task :notify do
    notify fetch(:notification)
  end

  after 'deploy:finished', 'notification:notify'
end
