class ActsAsNotifiableMigration < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.string :body
      t.timestamps

      # Make sure that columns length are long enough to contain
      # the required class names
      t.references :notifier, polymorphic: true
      t.references :notifiable, polymorphic: true
    end

    create_table :notifyings do |t|
      t.references :notification

      # Make sure that columns length are long enough to contain
      # the required class names
      t.references :notified, polymorphic: true

      t.boolean :is_read, default: true
      t.datetime :read_at, default: nil
    end

    add_index :notifyings,
              [:notification_id, :notified_id, :notified_type],
              unique: true, name: 'notifyings_idx'
  end

  def self.down
    drop_table :notifyings
    drop_table :notifications
  end
end
