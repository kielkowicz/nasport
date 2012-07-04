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

class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
end
