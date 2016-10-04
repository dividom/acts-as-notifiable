# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161004155803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notifiable_models", force: :cascade do |t|
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notifier_id"
    t.string   "notifier_type"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.integer  "notifyings_count", default: 0
  end

  add_index "notifications", ["notifiable_id"], name: "index_notifications_on_notifiable_id", using: :btree
  add_index "notifications", ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id", using: :btree
  add_index "notifications", ["notifiable_type"], name: "index_notifications_on_notifiable_type", using: :btree
  add_index "notifications", ["notifier_id"], name: "index_notifications_on_notifier_id", using: :btree
  add_index "notifications", ["notifier_type", "notifier_id"], name: "index_notifications_on_notifier_type_and_notifier_id", using: :btree
  add_index "notifications", ["notifier_type"], name: "index_notifications_on_notifier_type", using: :btree

  create_table "notifyings", force: :cascade do |t|
    t.integer  "notification_id"
    t.integer  "notified_id"
    t.string   "notified_type"
    t.boolean  "is_read",         default: true
    t.datetime "read_at"
  end

  add_index "notifyings", ["notification_id", "notified_id", "notified_type"], name: "notifyings_idx", unique: true, using: :btree
  add_index "notifyings", ["notification_id"], name: "index_notifyings_on_notification_id", using: :btree
  add_index "notifyings", ["notified_id"], name: "index_notifyings_on_notified_id", using: :btree
  add_index "notifyings", ["notified_type", "notified_id"], name: "index_notifyings_on_notified_type_and_notified_id", using: :btree
  add_index "notifyings", ["notified_type"], name: "index_notifyings_on_notified_type", using: :btree

  create_table "unnotifiable_models", force: :cascade do |t|
  end

end
