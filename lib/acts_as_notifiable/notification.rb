# encoding: utf-8
module ActsAsNotifiable
  class Notification < ActiveRecord::Base
    has_many :notifyings, dependent: :destroy, class_name: "::ActsAsNotifiable::Notifying"

    validates_presence_of :body
    validates_length_of :body, maximum: 255
  end
end
