module ActsAsNotifiable
  module Notifier

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      ##
      # Make model a notifier. This allows an instance of a model to claim ownership
      # of notifications.
      #
      # Example :
      #   class User
      #     acts_as_notifier
      #   end
      def acts_as_notifier(opts={})
        class_eval do
          sent_notifyings_scope = opts.delete(:scope)

          has_many :sent_notifyings, sent_notifyings_scope,
                    opts.merge(
                      as: :notifier,
                      dependant: :destroy,
                      class_name: '::ActsAsNotifiable::Notifying'
                    )

          has_many :sent_notifications,
                    through: :notifyings,
                    source: :notification,
                    class_name: '::ActsAsNotifiable::Notification'
        end

        include ActsAsNotifiable::Notifier::InstanceMethods
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
