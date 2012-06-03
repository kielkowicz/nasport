class AddEventEndToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_end, :datetime
  end
end
