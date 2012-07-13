# == Schema Information
#
# Table name: events
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  place_id    :integer
#  owner_id    :integer
#  event_day   :datetime
#  duration    :integer
#  end_time    :datetime
#  max_users   :integer
#  description :text
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
