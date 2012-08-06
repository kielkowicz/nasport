class AddReferencesToDisciplineInEventModel < ActiveRecord::Migration
  def change
    add_column :events, :discipline_id, :integer
  end
end
