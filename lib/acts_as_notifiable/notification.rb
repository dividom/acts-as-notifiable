# encoding: utf-8
module ActsAsNotifiable
  class Notification < ActiveRecord::Base

    has_many :notifyings,
              dependent: :destroy,
              class_name: "::ActsAsNotifiable::Notifying",
              counter_cache: true

    has_many :notifieds, -> { distinct },
              through: :notifyings,
              source: :notified,
              class_name: "::ActsAsNotifiable::Notified"

    belongs_to :notifiable,
                polymorphic: true

    belongs_to :notifier,
                polymorphic: true

    validates_presence_of :body
    validates_length_of :body, maximum: 255

    validate :ensure_notifiable
    validate :ensure_notifier

    ### SCOPES:

    def self.from(notifier)
      where(["notifyings.notifier_type = ? AND notifyings.notifier_id = ?", notifier.class.name, notifier.id]).
      select("notifications.*")
    end

    def self.to(notified)
      joins(:notifyings).
      where(["notifyings.notified_type = ? AND notifyings.notified_id = ?", notified.class.name, notified.id]).
      select("notifications.*")
    end

    def self.for(notifiable)
      where(["notifyings.notifiable_type = ? AND notifyings.notifiable_id = ?", notifiable.class.name, notifiable.id]).
      select("notifications.*")
    end

    def self.for_class(notifiable_class)
      where(["notifyings.notifiable_type = ?", notifiable_class]).
      select("notifications.*")
    end

    ### INSTANCE METHODS:

    def to_s
      self.body
    end

    def ensure_notifier
      errors.add(:notifier, "is not a ::ActsAsNotifiable::Notifier object") unless
        self.notifier.respond_to?(:is_notifier?) && self.notifier.is_notifier?
    end

    def ensure_notifiable
      errors.add(:notifiable, "is not a ::ActsAsNotifiable::Notifiable object") unless
        self.notifiable.respond_to?(:is_notifiable?) && self.notifiable.is_notifiable?
    end
  end
end
