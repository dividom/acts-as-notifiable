class CreateNotifiedModel < ActiveRecord::Migration
  def change
    create_table :notified_models do |t|
      t.string :name
    end
  end
end
