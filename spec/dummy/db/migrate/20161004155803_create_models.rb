class CreateModels < ActiveRecord::Migration
  def change
    create_table :unnotifiable_models do |t|
    end

    create_table :notifiable_models do |t|
    end
  end
end
