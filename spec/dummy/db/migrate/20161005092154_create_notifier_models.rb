class CreateNotifierModels < ActiveRecord::Migration
  def change
    create_table :notifier_models do |t|
      t.string :name
    end
  end
end
