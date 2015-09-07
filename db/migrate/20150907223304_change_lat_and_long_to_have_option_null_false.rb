class ChangeLatAndLongToHaveOptionNullFalse < ActiveRecord::Migration
  def change
    remove_column :users, :latitude, :decimal
    add_column :users, :latitude, :decimal, null: false

    remove_column :users, :longitude, :decimal
    add_column :users, :longitude, :decimal, null: false
  end
end
