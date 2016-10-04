class NotifiableModel < ActiveRecord::Base
  acts_as_notifiable

  self.abstract_class = true
end
