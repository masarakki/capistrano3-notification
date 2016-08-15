# Capistrano3::Notification

Notification for capistrano3.
Sending notification to irc/slack/... after deployment completed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano3-notification', require: false
```

## Usage

in `Capfile`:

```ruby
require 'capistrano3/notification'
```

## Configuration

### IRC notification

in `deploy.rb` or staging files:

```ruby
set :irc_host, 'example.com'
set :irc_port, 16667         # default: 6667
set :irc_channel, '#notice'
set :notifier, 'myproject' # default: 'capistrano'
set :notification, -> { "#{fetch(:application)} was deployed to #{fetch(:stage)}" } # this message is default
```

### Slack notification

```ruby
set :slack_webhook_url, 'https://hooks.slack.com/services/EX/AM/PLE'
set :slack_channel, '#notice'
set :slack_icon, ':ghost:'                     # use emoji
set :slack_icon, 'http://example.com/icon.png' # use image
set :notifier, 'myproject' # default: 'capistrano'
set :notification, -> { "#{fetch(:application)} was deployed to #{fetch(:stage)}" } # this message is default
```

### Other notification

**contribute me!**

## Notify manually

You can use `notify` method to send message.

```ruby
# lib/capistrano/tasks/foo.rake

task :foo do
  notify 'hello!'
end
```

## Contributing

1. Fork it ( https://github.com/masarakki/capistrano3-notification/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
