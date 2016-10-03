class ActsAsTaggableMigration < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.string :body
      t.timestamps
    end

    create_table :notifyings do |t|
      t.references :notification

      # Make sure that columns length are long enough to contain
      # the required class names
      t.references :notifiable, polymorphic: true
      t.references :notified, polymorphic: true
      t.references :notifier, polymorphic: true

      t.boolean :is_read
      t.datetime :read_at

      t.boolean :is_global
    end

    add_index :notifyings,
              [:notification_id, :notifiable_id, :notifiable_type, :notifier_id, :notifier_type, :notified_id, :notified_type],
              unique: true, name: 'notifyings_idx'
  end

  def self.down
    drop_table :notifyings
    drop_table :notifications
  end
end
