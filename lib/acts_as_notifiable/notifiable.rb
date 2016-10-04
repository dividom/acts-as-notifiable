module ActsAsNotifiable
  module Notifiable

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
      end
    end
  end
end
