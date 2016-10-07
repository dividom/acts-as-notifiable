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
      #
      def acts_as_notifier(opts={})
        class_eval do
          sent_notifications_scope = opts.delete(:scope)

          has_many :sent_notifications, sent_notifications_scope,
                    opts.merge(
                      as: :notifier,
                      dependent: :destroy,
                      class_name: '::ActsAsNotifiable::Notification'
                    )
        end

        include ActsAsNotifiable::Notifier::InstanceMethods
        extend ActsAsNotifiable::Notifier::SingletonMethods
      end

      def notifier?
        false
      end

      def is_notifier?
        notifier?
      end
    end

    module InstanceMethods

      ##
      # Notify a one or several @notifieds about a @notifiable, coming from self.
      # Doesn't save the notifications.
      # Returns an array of notifications
      #
      # Example :
      #   user.notify(message, user.father) # [::ActsAsNotifiable::Notification]
      # Or :
      #   user.notify(message, [user.sister, user.brother, user.grandma]) # []
      #
      def notify_from(notifiable, notifieds, opts={})
        notifieds = [*notifieds]
        notifyings = []
        opts[:body] ||= I18n.translate('acts_as_notifiable.notification.body')

        notifieds.each do |n|
          notifyings << ActsAsNotifiable::Notifying.new(
                          notified: n
                        )
        end

        return self.sent_notifications.build(
                  notifier: self,
                  notifiable: notifiable,
                  body: opts[:body],
                  notifieds: notifieds
                )
      end

      ##
      # Notify one or several @notifieds about a @notifiable, coming from self.
      # Returns whether self was saved or not
      #
      # Example :
      #   user.notify!(message, user.mother) # true
      # Or :
      #  user.notify!(message, [user.sister, user.aunt, user.counselor]) # true
      def notify_from!(notifiable, notifieds, opts)
        self.notify_from(notifiable, notifieds, opts)
        self.save
      end

      def notifier?
        self.class.is_notifier?
      end

      def is_notifier?
        notifier?
      end
    end

    module SingletonMethods
      def notifier?
        true
      end

      def is_notifier?
        notifier?
      end
    end
  end
end
