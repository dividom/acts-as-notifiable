module ActsAsNotifiable
  module Notifiable

    def notifiable?
      false
    end

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

        has_many :related_notifications, related_notifications_scope
                  opts.merge(
                    as: :notifiable
                    dependent: :destroy
                    class_name: '::ActsAsNotifiable::Notification'
                  )

        def self.notifiable?
          true
        end
      end

      include ActsAsNotifiable::Notifiable::InstanceMethods
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
      def notify(notifier, notifieds)
        notifieds = [*notifieds]

        notifieds.each do |n|
          self.related_notifications.build(
            notifier: notifier,
            notifiable: self,
            body: "Awesome notification body !",
            notifieds: notifieds
          )
        end

        self.notifications
      end

      ##
      # Notify one or several @notifieds about self, coming from @notifier.
      # Returns whether self was saved or not
      #
      # Example :
      #   message.notify!(user, user.mother) # true
      # Or :
      #  message.notify!(user, [user.sister, user.aunt, user.counselor]) # true
      def notify!(notifier, notifieds)
        self.notify(notifier, notifieds)
        self.save
      end
    end
  end
end
