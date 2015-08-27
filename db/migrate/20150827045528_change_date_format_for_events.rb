class ChangeDateFormatForEvents < ActiveRecord::Migration
  def change
    remove_column :events, :date, :date, null: false
    add_column :events, :date, :datetime, null: false
  end
end
