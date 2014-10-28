# Capistrano3::Notification

Notification for capistrano3

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano3-notification'
```

## Usage

in `Capfile`:

```ruby
require 'capistrano3/notification'
```

### IRC notification

in `deploy.rb` or staging files:

```ruby
set :irc_host, 'example.com'
set :irc_port, 16667         # default: 6667
set :irc_channel, '#notice'
set :irc_user, 'myproject' # default: 'capistrano'
set :notification, -> { "#{fetch(:application)} was deployed to #{fetch(:stage)}" } # this message is default
```

### Other notification

**contribute me!**

## Contributing

1. Fork it ( https://github.com/masarakki/capistrano3-notification/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
