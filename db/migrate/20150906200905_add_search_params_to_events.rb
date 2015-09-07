class AddSearchParamsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :search_param, :string, null: false
  end
end
