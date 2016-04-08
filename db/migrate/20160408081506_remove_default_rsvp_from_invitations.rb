class RemoveDefaultRsvpFromInvitations < ActiveRecord::Migration
  def change
    change_column_default :invitations, :rsvp, nil
    change_column_null :invitations, :rsvp, true
  end
end
