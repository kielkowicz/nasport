class AddPix1FiledToPlaces < ActiveRecord::Migration
  def self.up
    change_table :places do |t|
      t.has_attached_file  :pix1
    end
  end

  def self.down
    drop_attached_file :places, :pix1
  end
end
