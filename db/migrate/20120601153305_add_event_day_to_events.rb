class AddEventDayToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_day, :datetime
  end
end
