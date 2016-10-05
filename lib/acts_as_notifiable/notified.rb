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
                      dependent: :destroy,
                      class_name: '::ActsAsNotifiable::Notifying'
                    )

          has_many :notifications,
                    through: :received_notifyings,
                    source: :notification,
                    class_name: '::ActsAsNotifiable::Notification'
        end

        include ActsAsNotifiable::Notified::InstanceMethods
        extend ActsAsNotifiable::Notified::SingletonMethods
      end

      def notified?
        false
      end

      def is_notified?
        notified?
      end
    end

    module InstanceMethods

      ##
      # Notify self about a @notifiable, coming from @notifier.
      # Doesn't save the notifications.
      # Returns an array of notifications
      #
      # Example :
      #   user.notify(message, user.father) # [::ActsAsNotifiable::Notification]
      # Or :
      #   user.notify(message, [user.sister, user.brother, user.grandma]) # []
      #
      def notify_to(notifiable, notifier)

        self.notifications.build(
          notifier: notifier,
          notifiable: notifiable,
          body: "Awesome notification body !",
          notifieds: [self]
        )

        self.notifications
      end

      ##
      # Notify self about a @notifiable, coming from @notifier.
      # Returns whether self was saved or not
      #
      # Example :
      #   user.mother.notify!(message, user) # true
      #
      def notify_to!(notifiable, notifier)
        self.notify(notifiable, notifier)
        self.save
      end

      def notified?
        self.class.is_notified?
      end

      def is_notified?
        notified?
      end
    end

    module SingletonMethods
      def notified?
        true
      end

      def is_notified?
        notified?
      end
    end
  end
end
