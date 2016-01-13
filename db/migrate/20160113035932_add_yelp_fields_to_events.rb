class AddYelpFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :latitude, :decimal
    add_column :events, :longitude, :decimal
    add_column :events, :image, :string
  end
end
