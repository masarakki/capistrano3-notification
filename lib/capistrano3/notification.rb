require 'capistrano3/notification/version'
require 'capistrano3/notification/adapter'
%w(slack irc).each do |adapter|
  require "capistrano3/notification/#{adapter}"
end
require 'capistrano3/notification/dsl'

extend Capistrano3::Notification::DSL

load File.expand_path('../notification/tasks/notification.rake', __FILE__)
