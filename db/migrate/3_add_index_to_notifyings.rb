class AddIndexToNotifyings < ActiveRecord::Migration
  def self.up
    ##
    # Table : notifications
    #
    add_index :notifications, :notifier_type
    add_index :notifications, :notifier_id
    add_index :notifications, [:notifier_type, :notifier_id]

    add_index :notifications, :notifiable_type
    add_index :notifications, :notifiable_id
    add_index :notifications, [:notifiable_type, :notifiable_id]

    ##
    # Table : notifyings
    add_index :notifyings, :notification_id
    add_index :notifyings, :notified_type
    add_index :notifyings, :notified_id
    add_index :notifyings, [:notified_type, :notified_id]
  end

  def self.down
    ##
    # Table : notifications
    #
    remove_index :notifications, :notifier_type
    remove_index :notifications, :notifier_id
    remove_index :notifications, [:notifier_type, :notifier_id]

    remove_index :notifications, :notifiable_type
    remove_index :notifications, :notifiable_id
    remove_index :notifications, [:notifiable_type, :notifiable_id]

    ##
    # Table : notifyings
    remove_index :notifyings, :notification_id
    remove_index :notifyings, :notified_type
    remove_index :notifyings, :notified_id
    remove_index :notifyings, [:notified_type, :notified_id]
  end
end
