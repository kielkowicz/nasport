# == Schema Information
#
# Table name: reports
#
#  id         :integer         not null, primary key
#  event_id   :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
