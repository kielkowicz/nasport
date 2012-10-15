class AddLatitudeAndLongitudeToCity < ActiveRecord::Migration
  def change
    add_column :cities, :lat, :float

    add_column :cities, :lon, :float

  end
end
