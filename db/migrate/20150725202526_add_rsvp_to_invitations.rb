class AddRsvpToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :rsvp, :boolean, null: false, default: false
  end
end
