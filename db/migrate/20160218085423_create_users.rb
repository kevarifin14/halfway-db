class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone_number, unique: true
      t.string :pin
      t.boolean :verified, default: false
      t.string :access_token
      t.decimal :longitude
      t.decimal :latitude
      t.timestamps null: false
    end
  end
end
