require 'slack-notifier'

module Capistrano3
  module Notification
    class Slack < Adapter
      def notify(message)
        notifier_options = { username: user, channel: channel }.reject { |_x, y| y.nil? }
        ping_options = {}.tap do |h|
          h[icon_type] = icon if icon_type
        end
        ::Slack::Notifier.new(webhook_url, notifier_options).ping message, ping_options
      end

      private

      def webhook_url
        fetch(:slack_webhook_url)
      end

      def channel
        fetch(:slack_channel)
      end

      def icon
        fetch(:slack_icon) || nil
      end

      def icon_type
        case icon
        when /^:.+:/
          :icon_emoji
        when /^http/
          :icon_url
        end
      end

      def enabled?
        user && channel && webhook_url
      end
    end
  end
end
