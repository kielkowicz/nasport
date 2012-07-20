# == Schema Information
#
# Table name: places
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  address     :string(255)
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  closed      :boolean         default(FALSE)
#

class Place < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  belongs_to :city
end
