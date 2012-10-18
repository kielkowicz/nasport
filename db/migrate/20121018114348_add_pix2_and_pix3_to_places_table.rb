class AddPix2AndPix3ToPlacesTable < ActiveRecord::Migration
  def change
    add_attachment :places, :pix2
    add_attachment :places, :pix3
  end
end
