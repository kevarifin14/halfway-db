class AddMeetingPointAndAddressToEvents < ActiveRecord::Migration
  def change
    add_column :events, :meeting_point, :string
    add_column :events, :address, :string
    remove_column :events, :latitude
    remove_column :events, :longitude
  end
end
