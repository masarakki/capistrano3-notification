require 'forwardable'

module Capistrano3
  module Notification
    class Adapter
      extend Forwardable
      attr_reader :env
      def_delegators :@env, :fetch

      def initialize(env)
        @env = env
      end

      def notify(_message)
        raise 'this is abstract class'
      end

      private

      def user
        fetch(:notifier)
      end
    end
  end
end
