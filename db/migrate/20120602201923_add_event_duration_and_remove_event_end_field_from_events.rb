class AddEventDurationAndRemoveEventEndFieldFromEvents < ActiveRecord::Migration
  def change
    add_column :events, :duration, :integer
    remove_column :events, :event_end, :datetime
  end
end
