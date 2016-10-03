# encoding: utf-8
module ActsAsNotifiable
  class Notification < ActiveRecord::Base

    has_many :notifyings,
              dependent: :destroy,
              class_name: "::ActsAsNotifiable::Notifying"

    has_many :receivers, -> { distinct },
              through: :notifying,
              source: :notified,
              class: "::ActsAsNotifiable::Notified"

    has_many :notifiables, -> { distinct },
              through: :notifying,
              source: :notifiable,
              class_name: '::ActsAsNotifiable::Notifiable'

    validates_presence_of :body
    validates_length_of :body, maximum: 255
  end
end
