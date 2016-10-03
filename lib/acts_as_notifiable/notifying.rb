module ActsAsNotifiable
  class Notifying < ActiveRecord::Base

    belongs_to :notification, class_name: "::ActsAsNotifiable::Notification"
    belongs_to :notified, polymorphic: true
    belongs_to :notifiable, polymorphic: true

    scope :notified_to, ->(receiver) { where(notified: receiver) }
    scope :global, -> { where(is_global: true) }
    scope :unread, -> { where(is_read: true) }

    validates_presence_of :notification_id
    validates_uniqueness_of :notification_id, scope: [:notifiable_type, :notifiable_id, :notified_id, :notified_type]
  end
end
