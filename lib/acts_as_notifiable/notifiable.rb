module ActsAsNotifiable
  module Notifiable

    def acts_as_notifiable
      class_eval do
        has_many :notifyings, as: :notifiable, dependant: :destroy, class_name: '::ActsAsNotifiable::Notifying'
        has_many :notifications, through: :notifyings, source: :notification, class_name: '::ActsAsNotifiable::Notification'
      end
    end
  end
end
