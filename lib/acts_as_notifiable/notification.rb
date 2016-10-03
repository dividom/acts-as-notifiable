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

    ### SCOPES:

    def self.from(notifier)
      joins(:notifyings).
      where(["notifyings.notifier_type = ? AND notifyings.notifier_id = ?", notifier.class.name, notifier.id]).
      select("notifications.*")
    end

    def self.to(notified)
      joins(:notifyings).
      where(["notifyings.notified_type = ? AND notifyings.notified_id = ?", notified.class.name, notified.id]).
      select("notifications.*")
    end

    def self.for(notifiable)
      joins(:notifyings).
      where(["notifyings.notifiable_type = ? AND notifyings.notifiable_id = ?", notifiable.class.name, notifiable.id]).
      select("notifications.*")
    end

    def self.for_class(notifiable_class)
      joins(:notifyings).
      where(["notifyings.notifiable_type = ?", notifiable_class]).
      select("notifications.*")
    end
  end
end
