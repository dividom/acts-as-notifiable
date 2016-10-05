module ActsAsNotifiable
  module Notifiable

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      ##
      # Make a model notifiable. This allows an instance of a model to claim notifications
      # are related to it.
      #
      # Example :
      #   class Message
      #     acts_as_notifiable
      #   end
      def acts_as_notifiable(opts={})
        class_eval do
          related_notifications_scope = opts.delete(:scope)

          has_many :related_notifications, related_notifications_scope,
                    opts.merge(
                      as: :notifiable,
                      dependent: :destroy,
                      class_name: '::ActsAsNotifiable::Notification'
                    )
        end

        include ActsAsNotifiable::Notifiable::InstanceMethods
        extend ActsAsNotifiable::Notifiable::SingletonMethods
      end

      def notifiable?
        false
      end

      def is_notifiable?
        notified?
      end
    end

    module InstanceMethods

      ##
      # Notify one or several @notifieds about self, coming from @notifier.
      # Doesn't save the notifications.
      # Returns an array of notifications
      #
      # Example :
      #   message.notify(user, user.father) # [::ActsAsNotifiable::Notification]
      # Or :
      #   message.notify(user, [user.sister, user.brother, user.grandma]) # []
      #
      def notify_about(notifier, notifieds)
        notifieds = [*notifieds]
        notifyings = []

        notifieds.each do |n|
          notifyings << ActsAsNotifiable::Notifying.new(
                          notified: n
                        )
        end

        return self.related_notifications.build(
                      notifier: notifier,
                      notifiable: self,
                      body: "Awesome notification body !",
                      notifyings: notifyings
                    )
      end

      ##
      # Notify one or several @notifieds about self, coming from @notifier.
      # Returns whether self was saved or not
      #
      # Example :
      #   message.notify!(user, user.mother) # true
      # Or :
      #  message.notify!(user, [user.sister, user.aunt, user.counselor]) # true
      def notify_about!(notifier, notifieds)
        self.notify_about(notifier, notifieds)
        self.save
      end

      def notifiable?
        self.class.is_notifiable?
      end

      def is_notifiable?
        notifiable?
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
