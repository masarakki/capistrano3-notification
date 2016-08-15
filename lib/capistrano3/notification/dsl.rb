module Capistrano3
  module Notification
    module DSL
      def notify(message)
        return if dry_run?
        [Capistrano3::Notification::IRC,
         Capistrano3::Notification::Slack].each do |klass|
          klass.new(self).notify(message)
        end
      end
    end
  end
end
