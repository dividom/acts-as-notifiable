module ActsAsNotifiable
  class Notifying < ActiveRecord::Base

    belongs_to :notification, class_name: "::ActsAsNotifiable::Notification"
    belongs_to :notified, polymorphic: true

    scope :unread, -> { where(is_read: true) }

    validates_presence_of :notification_id
    validates_uniqueness_of :notification_id, scope: [:notified_id, :notified_type]
  end
end
