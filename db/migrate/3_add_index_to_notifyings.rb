class AddIndexToNotifyings < ActiveRecord::Migration
  def self.up
    add_index :notifyings, :notification_id
    add_index :notifyings, :notified_type
    add_index :notifyings, :notified_id
    add_index :notifyings, :notifier_type
    add_index :notifyings, :notifier_id
    add_index :notifyings, :notifiable_type
    add_index :notifyings, :notifiable_id

    add_index :notifyings, [:notified_type, :notified_id]
    add_index :notifyings, [:notifier_type, :notifier_id]
    add_index :notifyings, [:notifiable_type, :notifiable_id]
  end

  def self.down
    remove_index :notifyings, :notification_id
    remove_index :notifyings, :notified_type
    remove_index :notifyings, :notified_id
    remove_index :notifyings, :notifier_type
    remove_index :notifyings, :notifier_id
    remove_index :notifyings, :notifiable_type
    remove_index :notifyings, :notifiable_id

    remove_index :notifyings, [:notified_type, :notified_id]
    remove_index :notifyings, [:notifier_type, :notifier_id]
    remove_index :notifyings, [:notifiable_type, :notifiable_id]
  end
end
