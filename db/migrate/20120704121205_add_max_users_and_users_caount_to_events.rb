class AddMaxUsersAndUsersCaountToEvents < ActiveRecord::Migration
  def up
    add_column :events, :max_users, :integer
  end

  def down
    remove_column :events, :max_users
  end
end
