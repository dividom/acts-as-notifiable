class AddNotifyingsCounterCacheToNotifications < ActiveRecord::Migration
  def self.up
    add_column :notifications, :notifyings_count, :integer, default: 0

    ActsAsNotifiable::Notification.reset_column_information
    ActsAsNotifiable::Notification.find_each do |n|
      ActsAsNotifiable::Notification.reset_counters(n.id, :notifyings)
    end
  end

  def self.down
    remove_column :notifications, :notifyings_count
  end
end
