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
        # Notify a @notified about a @notifiable.
        # Doesn't save the notifications.
        #
        # Example :
        #   @user.notify(message, @user.sister)
        # Or :
        #   @user.notify(message, [@user.sister, @user.brother, @user.grandma])
        #
        def notify(notifiable, notifieds)
          notifieds = [*notifieds]
          notifications = []

          notifieds.each do |n|
            self.sent_notifyings.build(
              notifier: self,
              notifiable: notifiable,
              notified: n
            )
          end
        end

        ##
        # Notify a @notified about a @notifiable.
        #
        #
        #
        #
        def notify!(notifiable, notifieds)
          # TODO
        end
      end
    end
  end
end
