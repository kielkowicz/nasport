class AddClosedToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :closed, :boolean, :default=>false
  end
end
