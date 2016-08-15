require 'shout-bot'

module Capistrano3
  module Notification
    class IRC < Adapter
      def notify(message)
        ShoutBot.shout(url) { |irc| irc.say message } if enabled?
      end

      private

      def host
        env.fetch(:irc_host)
      end

      def port
        env.fetch(:irc_port)
      end

      def channel
        env.fetch(:irc_channel)
      end

      def enabled?
        user && host && port && channel && message
      end

      def url
        "irc://#{user}@#{host}:#{port}/#{channel}"
      end
    end
  end
end
