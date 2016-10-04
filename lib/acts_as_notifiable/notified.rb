module ActsAsNotifiable
  module Notified

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      ##
      # Make model a notified. This allows an instance of a model to claim receipt
      # of notifications.
      #
      # Example :
      #   class User
      #     acts_as_notified
      #   end
      def acts_as_notified(opts={})
        class_eval do
          received_notifyings_scope = opts.delete(:scope)

          has_many :received_notifyings, received_notifyings_scope,
                    opts.merge(
                      as: :notified,
                      dependant: :destroy,
                      class_name: '::ActsAsNotifiable::Notifying'
                    )

          has_many :notifications,
                    through: :received_notifyings,
                    source: :notification,
                    class_name: '::ActsAsNotifiable::Notification'
        end

        include ActsAsNotifiable::Notified::InstanceMethods
      end

      module InstanceMethods

        ##
        # TODO
        def notify()
        end
      end
    end
  end
end
