class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :event, index: true
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
