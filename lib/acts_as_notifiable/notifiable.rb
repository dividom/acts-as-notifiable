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
        related_notifyings_scope = options.delete(:scope)

        has_many :related_notifyings, related_notifyings_scope,
                  as: :notifiable,
                  dependant: :destroy,
                  class_name: '::ActsAsNotifiable::Notifying'

        has_many :related_notifications,
                  through: :notifyings,
                  source: :notification,
                  class_name: '::ActsAsNotifiable::Notification'
      end
    end
  end
end
